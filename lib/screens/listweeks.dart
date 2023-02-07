import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:timetable/models/timetable.dart';
import 'package:timetable/screens/currentweek.dart';

class ListWeeks extends StatelessWidget {
  const ListWeeks({super.key, required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        index: index,
        name: name,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.index, required this.name});

  final int index;
  final String name;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState(index, name);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.index, this.name);

  final int index;
  final String name;

  List<TimeTable> timetablelist = [];

  void initstate() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://ictis.ru/$index.html');
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);

    final titles = html
        .querySelectorAll('body > div.container > a')
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
          name,
          style: const TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: timetablelist.length,
        itemBuilder: (context, i) {
          final timetable = timetablelist[i];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentWeek(
                            title: '${timetable.number} неделя',
                            week: i + 1,
                            index: index,
                            name: name,
                          )),
                );
              },
              title: Text(
                '${timetable.number} неделя',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
