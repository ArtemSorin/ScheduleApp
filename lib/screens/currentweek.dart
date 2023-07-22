import 'package:flutter/material.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/currentday.dart';

import '../data/lists.dart';

class CurrentWeek extends StatelessWidget {
  const CurrentWeek(
      {super.key,
      required this.title,
      required this.week,
      required this.group,
      required this.weeks,
      required this.groupStr});

  final String title;
  final List<dynamic> weeks;
  final int week;
  final int group;
  final String groupStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurrentDayPage(
        title: title,
        week: week,
        group: group,
        weeks: weeks,
        groupStr: groupStr,
      ),
    );
  }
}

class CurrentDayPage extends StatelessWidget {
  const CurrentDayPage({
    Key? key,
    required this.title,
    required this.week,
    required this.group,
    required this.weeks,
    required this.groupStr,
  }) : super(key: key);

  final String title;
  final List<dynamic> weeks;
  final int week;
  final int group;
  final String groupStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(str: '$groupStr, $title'),
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
                      groupStr: groupStr,
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