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
    List<String> groups = [
      '1 курс',
      'КТбо1-7',
      'КТбо1-8',
      'КТбо1-9',
      'КТбо1-10',
      '2 курс',
      'КТбо2-7',
      'КТбо2-8',
      'КТбо2-9',
      'КТбо2-10',
      '3 курс',
      'КТбо3-7',
      'КТбо3-8',
      'КТбо3-9',
      'КТбо3-10',
      '4 курс',
      'КТбо4-7',
      'КТбо4-8',
      'КТбо4-9',
      'КТбо4-10',
    ];
    List<int> numgroups = [
      0,
      7,
      8,
      9,
      10,
      0,
      53,
      54,
      55,
      56,
      0,
      100,
      101,
      102,
      103,
      0,
      130,
      131,
      132,
      133
    ];
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
