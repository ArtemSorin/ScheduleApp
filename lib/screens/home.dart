import 'package:flutter/material.dart';
import 'package:timetable/data/shedule.dart';
import 'package:timetable/models/listweeks.dart';

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: const Color.fromARGB(255, 91, 117, 240),
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('О приложении'),
                    content: const Text(
                        'Это приложение для просмотра расписания студентов ИКТИБ кафедры МОП ЭВМ. \n\n'
                        'Для удобства расписание текущей недели выделено цветом.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color.fromARGB(255, 91, 117, 240)),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                              color: Color.fromARGB(255, 91, 117, 240)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.question_mark),
              color: const Color.fromARGB(255, 91, 117, 240),
            )
          ],
          title: const Text(
            'Расписание',
            style: TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
          ),
          centerTitle: true,
        ),
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
