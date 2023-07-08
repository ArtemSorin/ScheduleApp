import 'package:flutter/material.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/curentday.dart';

import '../data/lists.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.week,
    required this.group,
    required this.weeks,
    required this.groupstr,
  }) : super(key: key);

  final String title;
  final List<dynamic> weeks;
  final int week;
  final int group;
  final String groupstr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(str: '$groupstr, $title'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: days.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(days[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrentDay(
                      title: title,
                      name: ' ',
                      day: numdays[index],
                      week: week,
                      group: group,
                      groupstr: groupstr,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}