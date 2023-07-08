import 'package:flutter/material.dart';
import 'package:timetable/data/database.dart';
import 'package:timetable/models/appbar.dart';

class EditNote extends StatelessWidget {
  const EditNote({
    super.key,
    required this.title,
    required this.content,
    required this.id,
  });

  final int id;
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    final myControllerText = TextEditingController();
    final myControllerDescription = TextEditingController();

    return Scaffold(
      appBar: const MyAppBar(str: 'Редактировать заметку'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: title,
              ),
              controller: myControllerDescription,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: content,
              ),
              controller: myControllerText,
            ),
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    await NoteDatabase.instance.updateNote(
                      id: id,
                      title: myControllerDescription.text,
                      content: myControllerText.text,
                      timestamp: DateTime.now().toString(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 91, 117, 240),
                  ),
                  child: const Text('Редактировать'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    await NoteDatabase.instance.deleteNote(
                      id: id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 91, 117, 240),
                  ),
                  child: const Text('Удалить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
