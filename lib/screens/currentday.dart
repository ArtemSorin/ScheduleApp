import 'package:flutter/material.dart';
import 'package:timetable/data/schedule.dart';
import 'package:timetable/models/appbar.dart';

class CurrentDay extends StatelessWidget {
  const CurrentDay(
      {super.key,
      required this.title,
      required this.day,
      required this.week,
      required this.group,
      required this.name,
      required this.groupStr});

  final String title;
  final String name;
  final int day;
  final int week;
  final int? group;
  final String groupStr;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrentDayPage(
        title: title,
        day: day,
        week: week,
        group: group,
        name: name,
        groupStr: groupStr,
      ),
    );
  }
}

class CurrentDayPage extends StatefulWidget {
  const CurrentDayPage(
      {super.key,
      required this.title,
      required this.day,
      required this.week,
      required this.group,
      required this.name,
      required this.groupStr});

  final String title;
  final String name;
  final int day;
  final int week;
  final int? group;
  final String groupStr;

  @override
  State<CurrentDayPage> createState() =>
      // ignore: no_logic_in_create_state
      _CurrentDayPageState(title, day, week, group, name, groupStr);
}

class _CurrentDayPageState extends State<CurrentDayPage> {
  _CurrentDayPageState(
      this.title, this.day, this.week, this.group, this.name, this.groupStr);

  final String title;
  final String name;
  final int day;
  final int week;
  final int? group;
  final String groupStr;

  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable = fetchData(group!, week);
    return FutureBuilder<Map<String, dynamic>>(
        future: futureTable,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: MyAppBar(str: '$groupStr, $title'),
              body: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!['table']['table'][day]!.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    leading: Text(
                      snapshot.data!['table']['table'][1][index] == 'Время'
                          ? '⏰'
                          : snapshot.data!['table']['table'][1][index],
                      style: TextStyle(
                          color: snapshot.data!['table']['table'][day][index] ==
                                  'Время'
                              ? Colors.black
                              : const Color.fromARGB(255, 91, 117, 240),
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      snapshot.data!['table']['table'][day][index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ));
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 91, 117, 240),
            ),
          );
        });
  }
}
