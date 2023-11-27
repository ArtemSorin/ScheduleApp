import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/lists.dart';
import '../data/database.dart';
import '../models/appbar.dart';
import 'addnote.dart';
import 'editnote.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final StreamController<List<Map<String, dynamic>>> _notesController =
      StreamController<List<Map<String, dynamic>>>();

  late Stream<List<Map<String, dynamic>>> _notesStream;

  @override
  void initState() {
    super.initState();
    _notesStream = _notesController.stream;
    refreshNotes();
  }

  @override
  void dispose() {
    _notesController.close();
    super.dispose();
  }

  Future<void> refreshNotes() async {
    _notesController.sink.add(await NoteDatabase.instance.getAllNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: const MyAppBar(str: 'Заметки'),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNote(
                            id: snapshot.data![i]['id'],
                            title: snapshot.data![i]['title'],
                            content: snapshot.data![i]['content'],
                          ),
                        ),
                      ).then((value) {
                        refreshNotes();
                      });
                    },
                    title: Text(
                      snapshot.data![i]['title'].length > 20
                          ? snapshot.data![i]['title'].substring(0, 20) + '...'
                          : snapshot.data![i]['title'],
                      style: TextStyle(
                        color: lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(snapshot.data![i]['content'].length > 30
                        ? snapshot.data![i]['content'].substring(0, 30) + '...'
                        : snapshot.data![i]['content']),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: lightBlue,
                      ),
                      onPressed: () {
                        NoteDatabase.instance
                            .deleteNote(id: snapshot.data![i]['id']);
                        refreshNotes();
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(
              color: lightBlue,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNote()),
          );
          refreshNotes();
        },
        backgroundColor: lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
