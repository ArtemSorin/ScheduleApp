import 'package:flutter/material.dart';

import '../constants/lists.dart';
import '../data/schedule.dart';
import '../models/appbar.dart';
import 'currentweek.dart';

class ListWeeks extends StatelessWidget {
  const ListWeeks(
      {super.key,
      required this.group,
      required this.weeks,
      required this.groupStr});

  final int? group;
  final String groupStr;
  final List<dynamic> weeks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWeeksPage(
        group: group,
        weeks: weeks,
        groupStr: groupStr,
      ),
    );
  }
}

class ListWeeksPage extends StatefulWidget {
  const ListWeeksPage(
      {super.key,
      required this.group,
      required this.weeks,
      required this.groupStr});

  final int? group;
  final String groupStr;
  final List<dynamic> weeks;

  @override
  State<ListWeeksPage> createState() => _ListWeeksPageState();
}

class _ListWeeksPageState extends State<ListWeeksPage> {
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Schedule> futureTable = fetchDataWithoutWeeks(widget.group!);
    return Scaffold(
        appBar: MyAppBar(str: widget.groupStr),
        body: FutureBuilder<Schedule>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: snapshot.data!.weeks.length,
                    itemBuilder: (context, i) {
                      int currentDay = DateTime.now().weekday % 7 == 0
                          ? 6
                          : DateTime.now().weekday % 7;
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CurrentWeek(
                                        groupStr: widget.groupStr,
                                        title:
                                            '${snapshot.data!.weeks[i]} неделя',
                                        week: i + 1,
                                        group: widget.group!,
                                        day: currentDay,
                                        selectedDay: currentDay + 1,
                                      )),
                            );
                          },
                          title: Text(
                            '${snapshot.data!.weeks[i]} неделя',
                            style: TextStyle(
                                color: snapshot.data!.table.week == i + 1
                                    ? lightBlue
                                    : Colors.black,
                                fontWeight: snapshot.data!.table.week == i + 1
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(
                child: CircularProgressIndicator(
                  color: lightBlue,
                ),
              );
            }));
  }
}
