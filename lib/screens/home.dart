import 'package:flutter/material.dart';

import '../constants/lists.dart';
import '../data/schedule.dart';
import '../models/appbar.dart';
import 'weeks.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Schedule> futureTable = fetchDataWithoutWeeks(1);

  void initstate() {
    super.initState();
    futureTable = fetchDataWithoutWeeks(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Schedule>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    appBar: const MyAppBar(str: 'Расписание'),
                    body: ListView.builder(
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
                                                    weeks: snapshot.data!.weeks,
                                                  )),
                                        );
                                      },
                                    ),
                                  );
                      },
                    ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Расписание ещё не существует",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: lightBlue, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: lightBlue,
                ),
              );
            }));
  }
}
