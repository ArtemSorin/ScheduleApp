import 'package:flutter/material.dart';
import 'package:timetable/models/data.dart';
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
      body: MyHomePage(
        group: group,
        weeks: weeks,
        groupstr: groupstr,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.group,
      required this.weeks,
      required this.groupstr});

  final int group;
  final String groupstr;
  final List<dynamic> weeks;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState(group, weeks, groupstr);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.group, this.weeks, this.groupstr);

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              color: const Color.fromARGB(255, 91, 117, 240),
              icon: const Icon(Icons.menu),
              onPressed: () {}),
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
            groupstr,
            style: const TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: futureTable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!['table']['week']);
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
