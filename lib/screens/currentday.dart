import 'package:flutter/material.dart';

import '../data/schedule.dart';
import '../models/appbar.dart';

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
  State<CurrentDayPage> createState() => _CurrentDayPageState();
}

class _CurrentDayPageState extends State<CurrentDayPage> {
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable =
        fetchData(widget.group!, widget.week);
    return FutureBuilder<Map<String, dynamic>>(
        future: futureTable,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: MyAppBar(str: '${widget.groupStr}, ${widget.title}'),
              body: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!['table']['table'][widget.day]!.length,
                itemBuilder: (context, index) {
                  TimeOfDay time1 = TimeOfDay(
                      hour: snapshot.data!['table']['table'][1][index] ==
                              'Время'
                          ? 23
                          : int.parse(snapshot.data!['table']['table'][1][index]
                              .substring(0, 2)),
                      minute: snapshot.data!['table']['table'][1][index] ==
                              'Время'
                          ? 59
                          : int.parse(snapshot.data!['table']['table'][1][index]
                              .substring(3, 5)));
                  TimeOfDay time2 = TimeOfDay(
                      hour: snapshot.data!['table']['table'][1][index] ==
                              'Время'
                          ? 23
                          : int.parse(snapshot.data!['table']['table'][1][index]
                              .substring(6, 8)),
                      minute: snapshot.data!['table']['table'][1][index] ==
                              'Время'
                          ? 59
                          : int.parse(snapshot.data!['table']['table'][1][index]
                              .substring(9, 11)));
                  DateTime now = DateTime.now();
                  TimeOfDay currentTime =
                      TimeOfDay(hour: now.hour, minute: now.minute);
                  int time1InMinutes = time1.hour * 60 + time1.minute;
                  int time2InMinutes = time2.hour * 60 + time2.minute;
                  int currentTimeInMinutes =
                      currentTime.hour * 60 + currentTime.minute;
                  int comparison1 =
                      time1InMinutes.compareTo(currentTimeInMinutes);
                  int comparison2 =
                      time2InMinutes.compareTo(currentTimeInMinutes);
                  return Card(
                      color: (comparison1 < 0 && comparison2 > 0)
                          ? const Color.fromARGB(255, 91, 117, 240)
                          : const Color.fromARGB(255, 255, 255, 255),
                      child: ListTile(
                        leading: Text(
                          snapshot.data!['table']['table'][1][index] == 'Время'
                              ? '⏰'
                              : snapshot.data!['table']['table'][1][index],
                          style: TextStyle(
                              color: snapshot.data!['table']['table']
                                          [widget.day][index] ==
                                      'Время'
                                  ? Colors.black
                                  : (comparison1 < 0 && comparison2 > 0)
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(255, 91, 117, 240),
                              fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          snapshot.data!['table']['table'][widget.day][index],
                          style: (comparison1 < 0 && comparison2 > 0)
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.black),
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
