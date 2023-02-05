import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:timetable/models/subjects.dart';

class CurrentDay extends StatelessWidget {
  const CurrentDay(
      {super.key,
      required this.title,
      required this.index,
      required this.week});

  final String title;
  final int index;
  final int week;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
        index: index,
        week: week,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.index,
      required this.week});

  final String title;
  final int index;
  final int week;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState(title, index, week);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.title, this.index, this.week);

  final String title;
  final int index;
  final int week;
  List<Subjects> timetablelist = [];

  void initstate() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://ictis.ru/54.html/$week');
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);

    final titlesNumber = html
        .querySelectorAll(
            'body > div.container > div > table > tbody > tr.day-0 > td')
        .map((e) => e.innerHtml.trim())
        .toList();

    final titlesTime = html
        .querySelectorAll(
            'body > div.container > div > table > tbody > tr.day-1 > td')
        .map((e) => e.innerHtml.trim())
        .toList();

    final titlesSubject = html
        .querySelectorAll(
            'body > div.container > div > table > tbody > tr.day-$index > td')
        .map((e) => e.innerHtml.trim())
        .toList();

    if (!mounted) return;

    setState(() {
      timetablelist = List.generate(
          titlesNumber.length,
          (index) => Subjects(
              number: titlesNumber[index],
              time: titlesTime[index],
              name: '',
              subject: titlesSubject[index]));
    });
  }

  @override
  Widget build(BuildContext context) {
    String str =
        '<span class="table-ext-icon" title="Дистанционная пара">📺</span>';
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
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: timetablelist.length,
        itemBuilder: (context, index) {
          final timetable = timetablelist[index];
          return ListTile(
            leading: Text(
              timetable.time == 'Время' ? 'Время           ' : timetable.time,
              style: TextStyle(
                  color: timetable.time == 'Время'
                      ? Colors.black
                      : const Color.fromARGB(255, 91, 117, 240),
                  fontWeight: FontWeight.bold),
            ),
            title: Text(
              timetable.subject.replaceAll(str, '').trim(),
              style: const TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}
