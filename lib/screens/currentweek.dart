import 'package:flutter/material.dart';
import 'package:timetable/models/data.dart';
import 'package:timetable/screens/curentday.dart';

class CurrentWeek extends StatelessWidget {
  const CurrentWeek(
      {super.key,
      required this.title,
      required this.week,
      required this.group,
      required this.weeks,
      required this.groupstr});

  final String title;
  final List<dynamic> weeks;
  final int week;
  final int group;
  final String groupstr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(
        title: title,
        week: week,
        group: group,
        weeks: weeks,
        groupstr: groupstr,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.week,
      required this.group,
      required this.weeks,
      required this.groupstr});

  final String title;
  final List<dynamic> weeks;
  final int week;
  final int group;
  final String groupstr;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() =>
      _MyHomePageState(title, week, group, weeks, groupstr);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(
      this.title, this.week, this.group, this.weeks, this.groupstr);

  final String title;
  final List<dynamic> weeks;
  final int week;
  final int group;
  final String groupstr;

  List<TableSh> timetablelist = [];

  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          '$groupstr, $title',
          style: const TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            child: ListTile(
              title: const Text('Понедельник'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentDay(
                            title: title,
                            name: ' ',
                            day: 2,
                            week: week,
                            group: group,
                            groupstr: groupstr,
                          )),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Вторник'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentDay(
                            title: title,
                            name: ' ',
                            day: 3,
                            week: week,
                            group: group,
                            groupstr: groupstr,
                          )),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Среда'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentDay(
                            title: title,
                            name: ' ',
                            day: 4,
                            week: week,
                            group: group,
                            groupstr: groupstr,
                          )),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Четверг'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentDay(
                            title: title,
                            name: ' ',
                            day: 5,
                            week: week,
                            group: group,
                            groupstr: groupstr,
                          )),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Пятница'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentDay(
                            title: title,
                            name: ' ',
                            day: 6,
                            week: week,
                            group: group,
                            groupstr: groupstr,
                          )),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Суббота'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentDay(
                            title: title,
                            name: ' ',
                            day: 7,
                            week: week,
                            group: group,
                            groupstr: groupstr,
                          )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
