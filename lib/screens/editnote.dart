import 'package:flutter/material.dart';

import '../constants/lists.dart';
import '../data/database.dart';
import '../models/appbar.dart';

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
      appBar: const MyAppBar(str: 'Редактировать заметку'),
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
        onPressed: () {
          NoteDatabase.instance
              .updateNote(
            id: id,
            title: myControllerTitle.text,
            content: myControllerContent.text,
            timestamp: DateTime.now().toString(),
          )
              .then((_) {
            Navigator.pop(context);
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('An error occurred: $error')));
          });
        },
        backgroundColor: lightBlue,
        child: const Icon(Icons.create),
      ),
    );
  }
}
