import 'package:flutter/material.dart';
import 'package:timetable/models/data.dart';

class CurrentDay extends StatelessWidget {
  const CurrentDay(
      {super.key,
      required this.title,
      required this.day,
      required this.week,
      required this.group,
      required this.name,
      required this.groupstr});

  final String title;
  final String name;
  final int day;
  final int week;
  final int group;
  final String groupstr;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
        day: day,
        week: week,
        group: group,
        name: name,
        groupstr: groupstr,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.day,
      required this.week,
      required this.group,
      required this.name,
      required this.groupstr});

  final String title;
  final String name;
  final int day;
  final int week;
  final int group;
  final String groupstr;

  @override
  State<MyHomePage> createState() =>
      // ignore: no_logic_in_create_state
      _MyHomePageState(title, day, week, group, name, groupstr);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(
      this.title, this.day, this.week, this.group, this.name, this.groupstr);

  final String title;
  final String name;
  final int day;
  final int week;
  final int group;
  final String groupstr;

  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> futureTable = fetchData(group, week);
    return FutureBuilder<Map<String, dynamic>>(
        future: futureTable,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                title: Text(
                  '$groupstr, $title',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
                ),
                centerTitle: true,
              ),
              body: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!['table']['table'][day]!.length,
                itemBuilder: (context, index) {
                  print(snapshot.data!['table']['table'][day][index]);
                  return Card(
                      child: ListTile(
                    leading: Text(
                      snapshot.data!['table']['table'][1][index] == 'Время'
                          ? '⏰'
                          : snapshot.data!['table']['table'][1][index],
                      style: TextStyle(
                          color: snapshot.data!['table']['table'][day][index] ==
                                  'Время'
                              ? Colors.black
                              : const Color.fromARGB(255, 91, 117, 240),
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      snapshot.data!['table']['table'][day][index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ));
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 91, 117, 240),
            ),
          );
        });
  }
}
