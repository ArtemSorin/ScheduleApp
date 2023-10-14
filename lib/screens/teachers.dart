import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../models/appbar.dart';

class Teachers extends StatelessWidget {
  const Teachers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TeachersPage(),
    );
  }
}

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  List<String> list = [];

  @override
  void initState() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://mopevm.wordpress.com/преподаватели/');
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);

    final titles = html
        .querySelectorAll('#post-28 > div > table > tbody > tr > td > a')
        .map((e) => e.innerHtml.trim())
        .toList();

    if (!mounted) return;

    setState(() {
      list = titles;
    });
  }

  @override
  Widget build(BuildContext context) {
    getWebsiteData();
    return Scaffold(
      appBar: const MyAppBar(str: 'Сотрудники'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: list.length,
        itemBuilder: (context, i) {
          return list[i].contains('@')
              ? Container()
              : Card(
                  child: ListTile(
                    onTap: () {
                      /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentWeek(
                            title: '${timetable.number} неделя',
                            week: i + 1,
                            index: index,
                            name: name,
                          )),
                );*/
                    },
                    title: Text(
                      list[i],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
