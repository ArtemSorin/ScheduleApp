import 'package:flutter/material.dart';
import 'package:timetable/data/schedule.dart';
import 'package:timetable/models/appbar.dart';

import '../constants/lists.dart';

class CurrentWeek extends StatelessWidget {
  const CurrentWeek(
      {super.key,
      required this.title,
      required this.day,
      required this.week,
      required this.group,
      required this.groupStr,
      required this.selectedDay});

  final String title;
  final int day;
  final int week;
  final int group;
  final String groupStr;
  final int selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurrentWeekPage(
        title: title,
        day: day,
        week: week,
        group: group,
        groupStr: groupStr,
        selectedDay: selectedDay,
      ),
    );
  }
}

// ignore: must_be_immutable
class CurrentWeekPage extends StatefulWidget {
  CurrentWeekPage(
      {super.key,
      required this.title,
      required this.day,
      required this.week,
      required this.group,
      required this.groupStr,
      required this.selectedDay});

  final String title;
  int day;
  final int week;
  final int? group;
  final String groupStr;
  int selectedDay;

  @override
  State<CurrentWeekPage> createState() => _CurrentWeekPageState();
}

class _CurrentWeekPageState extends State<CurrentWeekPage> {
  _CurrentWeekPageState();

  late Future<Schedule> futureTable;

  @override
  void initState() {
    super.initState();
    futureTable = fetchData(widget.group!, widget.week);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<Schedule>(
        future: futureTable,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: MyAppBar(
                    str: '${widget.groupStr}  |  ${widget.week} неделя'),
                body: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: SizedBox(
                              width: width / 4,
                              height: 20,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: i + 2 == widget.selectedDay
                                        ? MaterialStateProperty.all(
                                            const Color.fromARGB(
                                                255, 91, 117, 240))
                                        : MaterialStateProperty.all(
                                            Colors.white)),
                                child: Text(
                                  snapshot.data!.table.table[i + 2][0],
                                  style: i + 2 == widget.selectedDay
                                      ? const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))
                                      : const TextStyle(
                                          color: Color.fromARGB(
                                              255, 91, 117, 240)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.selectedDay = i + 2;
                                    futureTable =
                                        fetchData(widget.group!, widget.week);
                                    widget.day = widget.selectedDay;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: snapshot
                            .data!.table.table[widget.selectedDay].length,
                        itemBuilder: (context, index) {
                          TimeOfDay time1 = TimeOfDay(
                              hour: snapshot.data!.table.table[1][index] ==
                                      'Время'
                                  ? 23
                                  : int.parse(snapshot
                                      .data!.table.table[1][index]
                                      .substring(0, 2)),
                              minute: snapshot.data!.table.table[1][index] ==
                                      'Время'
                                  ? 59
                                  : int.parse(snapshot
                                      .data!.table.table[1][index]
                                      .substring(3, 5)));
                          TimeOfDay time2 = TimeOfDay(
                              hour: snapshot.data!.table.table[1][index] ==
                                      'Время'
                                  ? 23
                                  : int.parse(snapshot
                                      .data!.table.table[1][index]
                                      .substring(6, 8)),
                              minute: snapshot.data!.table.table[1][index] ==
                                      'Время'
                                  ? 59
                                  : int.parse(snapshot
                                      .data!.table.table[1][index]
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
                                  ? lightBlue
                                  : const Color.fromARGB(255, 255, 255, 255),
                              child: ListTile(
                                leading: Text(
                                  snapshot.data!.table.table[1][index] ==
                                          'Время'
                                      ? '⏰'
                                      : snapshot.data!.table.table[1][index],
                                  style: TextStyle(
                                      color: snapshot.data!.table
                                                  .table[widget.day][index] ==
                                              'Время'
                                          ? Colors.black
                                          : (comparison1 < 0 && comparison2 > 0)
                                              ? const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : const Color.fromARGB(
                                                  255, 91, 117, 240),
                                      fontWeight: FontWeight.bold),
                                ),
                                title: Text(
                                  snapshot.data!.table.table[widget.selectedDay]
                                      [index],
                                  style: (comparison1 < 0 && comparison2 > 0)
                                      ? const TextStyle(color: Colors.white)
                                      : const TextStyle(color: Colors.black),
                                ),
                              ));
                        },
                      ),
                    )
                  ],
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(
              color: lightBlue,
            ),
          );
        });
  }
}
