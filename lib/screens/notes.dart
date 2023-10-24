import 'dart:async';

import 'package:flutter/material.dart';

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
                      style: const TextStyle(
                        color: Color.fromARGB(255, 91, 117, 240),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(snapshot.data![i]['content'].length > 30
                        ? snapshot.data![i]['content'].substring(0, 30) + '...'
                        : snapshot.data![i]['content']),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Color.fromARGB(255, 91, 117, 240),
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
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 91, 117, 240),
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
        backgroundColor: const Color.fromARGB(255, 91, 117, 240),
        child: const Icon(Icons.add),
      ),
    );
  }
}
