import 'package:flutter/material.dart';
import 'package:timetable/data/schedule.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/currentday.dart';

class ListWeeks extends StatelessWidget {
  const ListWeeks({super.key, required this.group, required this.groupStr});

  final int? group;
  final String groupStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWeeksPage(
        group: group,
        groupStr: groupStr,
      ),
    );
  }
}

class ListWeeksPage extends StatefulWidget {
  const ListWeeksPage({super.key, required this.group, required this.groupStr});

  final int? group;
  final String groupStr;

  @override
  State<ListWeeksPage> createState() =>
      // ignore: no_logic_in_create_state
      _ListWeeksPageState(group, groupStr);
}

class _ListWeeksPageState extends State<ListWeeksPage> {
  _ListWeeksPageState(this.group, this.groupStr);

  final int? group;
  final String groupStr;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable = fetchDataWithoutParams(group!);
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    appBar: MyAppBar(str: groupStr),
                    body: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: snapshot.data!['weeks']!.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CurrentDay(
                                            groupStr: groupStr,
                                            title:
                                                '${snapshot.data!['weeks'][i]} неделя',
                                            week: i + 1,
                                            group: group!,
                                            day: 2,
                                            selectedDay: 2,
                                          )),
                                );
                              },
                              title: Text(
                                '${snapshot.data!['weeks'][i]} неделя',
                                style: TextStyle(
                                    color:
                                        snapshot.data!['table']['week'] == i + 1
                                            ? const Color.fromARGB(
                                                255, 91, 117, 240)
                                            : Colors.black,
                                    fontWeight:
                                        snapshot.data!['table']['week'] == i + 1
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                              ),
                            ),
                          );
                        }));
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
