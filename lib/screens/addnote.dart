import 'package:flutter/material.dart';
import 'package:timetable/data/database.dart';
import 'package:timetable/models/appbar.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final myControllerText = TextEditingController();
    final myControllerDescription = TextEditingController();

    return Scaffold(
      appBar: const MyAppBar(str: 'Создать заметку'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Текст',
              ),
              controller: myControllerDescription,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Описание',
              ),
              controller: myControllerText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                await NoteDatabase.instance.addNewNote(
                  title: myControllerDescription.text,
                  content: myControllerText.text,
                  timestamp: DateTime.now().toString(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 91, 117, 240),
              ),
              child: const Text('Добавить'),
            ),
          ),
        ],
      ),
    );
  }
}
