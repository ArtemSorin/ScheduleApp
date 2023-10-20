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
    final myControllerTitle = TextEditingController();
    final myControllerContent = TextEditingController();

    myControllerTitle.text = title;
    myControllerContent.text = content;

    return Scaffold(
      //appBar: const MyAppBar(str: 'Редактировать заметку'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
          await NoteDatabase.instance.updateNote(
            id: id,
            title: myControllerTitle.text,
            content: myControllerContent.text,
            timestamp: DateTime.now().toString(),
          );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
        backgroundColor: const Color.fromARGB(255, 91, 117, 240),
        child: const Icon(Icons.create),
      ),
    );
  }
}
