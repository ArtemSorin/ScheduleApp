import 'package:flutter/material.dart';
import 'package:timetable/models/data.dart';
import 'package:timetable/screens/listweeks.dart';

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
            'Главная',
            style: TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    const ListTile(
                      title: Text(
                        '1 курс',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо1-7'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо1-7',
                                      group: 7,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо1-8'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо1-8',
                                      group: 8,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо1-9'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо1-9',
                                      group: 9,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо1-10'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо1-10',
                                      group: 10,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        '2 курс',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо2-7'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо2-7',
                                      group: 53,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо2-8'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо2-8',
                                      group: 54,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо2-9'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо2-9',
                                      group: 55,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо2-10'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо2-10',
                                      group: 56,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        '3 курс',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо3-7'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо3-7',
                                      group: 100,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо3-8'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо3-8',
                                      group: 101,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо3-9'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо3-9',
                                      group: 102,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо3-10'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо3-10',
                                      group: 103,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    const ListTile(
                      title: Text(
                        '4 курс',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо4-7'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо4-7',
                                      group: 130,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо4-8'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо4-8',
                                      group: 131,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо4-9'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      group: 132,
                                      weeks: snapshot.data!['weeks'],
                                      groupstr: 'КТбо4-9',
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('КТбо4-10'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeeks(
                                      groupstr: 'КТбо4-10',
                                      group: 133,
                                      weeks: snapshot.data!['weeks'],
                                    )),
                          );
                        },
                      ),
                    ),
                  ],
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
