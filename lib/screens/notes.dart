import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timetable/data/database.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/addnote.dart';
import 'package:timetable/screens/editnote.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => NotesState();
}

class NotesState extends State<Notes> {
  late Future<List<Map<String, dynamic>>> notes;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    setState(() {
      notes = NoteDatabase.instance.getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: const MyAppBar(str: 'Заметки'),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notes,
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
                      );
                    },
                    title: Text(
                      snapshot.data![i]['title'],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 91, 117, 240),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(snapshot.data![i]['content']),
                    trailing: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 91, 117, 240),
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