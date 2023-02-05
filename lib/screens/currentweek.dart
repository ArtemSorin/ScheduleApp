import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:timetable/models/timetable.dart';
import 'package:timetable/screens/curentday.dart';

class CurrentWeek extends StatelessWidget {
  const CurrentWeek({super.key, required this.title, required this.week});

  final String title;
  final int week;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
        week: week,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.week});

  final String title;
  final int week;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState(title, week);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.title, this.week);

  final String title;
  final int week;
  List<TimeTable> timetablelist = [];

  void initstate() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://ictis.ru/54.html/$week');
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);

    final titles = html
        .querySelectorAll(
            'body > div.container > div > table > tbody > tr > td')
        .map((e) => e.innerHtml.trim())
        .toList();

    if (!mounted) return;

    setState(() {
      timetablelist = List.generate(
          titles.length, (index) => TimeTable(number: titles[index]));
    });
  }

  @override
  Widget build(BuildContext context) {
    getWebsiteData();
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
            onPressed: () {},
            icon: const Icon(Icons.person),
            color: const Color.fromARGB(255, 91, 117, 240),
          )
        ],
        title: Text(
          title,
          style: const TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Text('Понедельник'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                          index: 2,
                          week: week,
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Вторник'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                          index: 3,
                          week: week,
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Среда'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                          index: 4,
                          week: week,
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Четверг'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                          index: 5,
                          week: week,
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Пятница'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                          index: 6,
                          week: week,
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Суббота'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                          index: 7,
                          week: week,
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}

/*

ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: timetablelist.length,
        itemBuilder: (context, index) {
          final timetable = timetablelist[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentDay(
                          title: title,
                        )),
              );
            },
            leading: Text(
              timetable.number,
              style: const TextStyle(color: Colors.black),
            ),
          );
        },
      ),

 */