import 'package:flutter/material.dart';
import 'package:timetable/data/schedule.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/currentweek.dart';

class ListWeeks extends StatelessWidget {
  const ListWeeks(
      {super.key,
      required this.group,
      required this.weeks,
      required this.groupstr});

  final int group;
  final String groupstr;
  final List<dynamic> weeks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWeeksPage(
        group: group,
        weeks: weeks,
        groupstr: groupstr,
      ),
    );
  }
}

class ListWeeksPage extends StatefulWidget {
  const ListWeeksPage(
      {super.key,
      required this.group,
      required this.weeks,
      required this.groupstr});

  final int group;
  final String groupstr;
  final List<dynamic> weeks;

  @override
  // ignore: no_logic_in_create_state
  State<ListWeeksPage> createState() => _ListWeeksPageState(group, weeks, groupstr);
}

class _ListWeeksPageState extends State<ListWeeksPage> {
  _ListWeeksPageState(this.group, this.weeks, this.groupstr);

  final int group;
  final String groupstr;
  final List<dynamic> weeks;

  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable = fetchDataWithoutParams(group);
    return Scaffold(
        appBar: MyAppBar(str: groupstr),
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: snapshot.data!['weeks']!.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CurrentWeek(
                                        groupstr: groupstr,
                                        title:
                                            '${snapshot.data!['weeks'][i]} неделя',
                                        week: i + 1,
                                        group: group,
                                        weeks: weeks,
                                      )),
                            );
                          },
                          title: Text(
                            '${snapshot.data!['weeks'][i]} неделя',
                            style: TextStyle(
                                color: snapshot.data!['table']['week'] == i + 1
                                    ? const Color.fromARGB(255, 91, 117, 240)
                                    : Colors.black,
                                fontWeight:
                                    snapshot.data!['table']['week'] == i + 1
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 91, 117, 240),
                ),
              );
            }));
  }
}
