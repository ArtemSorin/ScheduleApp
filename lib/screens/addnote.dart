import 'package:flutter/material.dart';
import 'package:timetable/data/database.dart';
import 'package:timetable/models/appbar.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final myControllerTitle = TextEditingController();
    final myControllerContent = TextEditingController();

    return Scaffold(
      appBar: const MyAppBar(str: 'Создать заметку'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Название',
                contentPadding: EdgeInsets.all(10.0),
              ),
              controller: myControllerTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Описание',
                contentPadding: EdgeInsets.all(10.0),
              ),
              controller: myControllerContent,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: () async {
          await NoteDatabase.instance.addNewNote(
                  title: myControllerTitle.text,
                  content: myControllerContent.text,
                  timestamp: DateTime.now().toString(),
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
        },
        backgroundColor: const Color.fromARGB(255, 91, 117, 240),
        child: const Icon(Icons.add),
      ),
    );
  }
}
