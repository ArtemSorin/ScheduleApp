import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timetable/data/database.dart';
import 'package:timetable/screens/addnote.dart';
import 'package:timetable/screens/editnote.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => NotesState();
}

class NotesState extends State<Notes> {
  late Future<List<Map<String, dynamic>>> notes;

  @override
  void initState() {
    super.initState();
    notes = NoteDatabase.instance.getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: const Color.fromARGB(255, 91, 117, 240),
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('О приложении'),
                  content: const Text(
                      'Это приложение для просмотра расписания студентов ИКТИБ кафедры МОП ЭВМ. \n\n'
                      'Для удобства расписание текущей недели выделено цветом.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text(
                        'Cancel',
                        style:
                            TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text(
                        'OK',
                        style:
                            TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.question_mark),
            color: const Color.fromARGB(255, 91, 117, 240),
          )
        ],
        title: const Text(
          'Заметки',
          style: TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
        ),
        centerTitle: true,
      ),
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
                                )),
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
          setState(() {
            notes = NoteDatabase.instance.getAllNotes();
          });
        },
        backgroundColor: const Color.fromARGB(255, 91, 117, 240),
        child: const Icon(Icons.add),
      ),
    );
  }
}
