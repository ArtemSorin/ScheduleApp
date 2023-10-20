import 'package:flutter/material.dart';
import 'package:timetable/data/schedule.dart';
import 'package:timetable/models/appbar.dart';
import 'package:timetable/screens/weeks.dart';

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
        //appBar: const MyAppBar(str: 'Расписание'),
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return groups[index] == '1 курс' ||
                            groups[index] == '2 курс' ||
                            groups[index] == '3 курс' ||
                            groups[index] == '4 курс'
                        ? ListTile(
                            title: Text(
                              groups[index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : numgroups[index] == null
                            ? const Card()
                            : Card(
                                child: ListTile(
                                  title: Text(groups[index]),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListWeeks(
                                                groupStr: groups[index],
                                                group: numgroups[index],
                                              )),
                                    );
                                  },
                                ),
                              );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Расписание ещё не существует",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 91, 117, 240),
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 91, 117, 240),
                ),
              );
            }));
  }
}
