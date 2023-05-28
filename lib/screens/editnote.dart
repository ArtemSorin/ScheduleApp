import 'package:flutter/material.dart';
import 'package:timetable/data/database.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: const Color.fromARGB(255, 91, 117, 240),
            icon: const Icon(Icons.menu),
            onPressed: () {}),
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
          'Создать заметку',
          style: TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
        ),
        centerTitle: true,
      ),
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
