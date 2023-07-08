import 'package:flutter/material.dart';
import 'package:timetable/data/shedule.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/listweeks.dart';

import '../data/lists.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Map<String, dynamic>> futureTable = fetchDataWithoutParams(1);

  void initstate() {
    super.initState();
    futureTable = fetchDataWithoutParams(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(str: 'Расписание'),
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return index % 5 == 0
                        ? ListTile(
                            title: Text(
                              groups[index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Card(
                            child: ListTile(
                              title: Text(groups[index]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListWeeks(
                                            groupstr: groups[index],
                                            group: numgroups[index],
                                            weeks: snapshot.data!['weeks'],
                                          )),
                                );
                              },
                            ),
                          );
                  },
                );
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
