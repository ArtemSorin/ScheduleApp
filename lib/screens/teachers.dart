import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:timetable/screens/currentteacher.dart';

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
  List<String> listTitles = [];
  List<String?> listImages = [];
  List<String> listPosts = [];
  List<String> listMails = [];

  @override
  void initState() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://sites.google.com/view/mopevm/');
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);

    final titles =
        html.querySelectorAll('a').map((e) => e.innerHtml.trim()).toList();
    final images =
        html.querySelectorAll('img').map((e) => e.attributes['src']).toList();
    final posts =
        html.querySelectorAll('small').map((e) => e.innerHtml.trim()).toList();
    final mails =
        html.querySelectorAll('small').map((e) => e.innerHtml.trim()).toList();

    if (!mounted) return;

    setState(() {
      listTitles = titles.sublist(35, 51);
      listImages = images.sublist(17, 33);
      for (int i = 2; i < 34; i += 2) {
        listPosts.add(posts[i]);
      }
      for (int i = 3; i < 35; i += 2) {
        listMails.add(mails[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getWebsiteData();
    return Scaffold(
      appBar: const MyAppBar(str: 'Сотрудники'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: listTitles.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentTeacher(
                            title: listTitles[i],
                            image: listImages[i]!,
                            post: listPosts[i],
                            mail: listMails[i],
                          )),
                );
              },
              title: Text(
                listTitles[i],
              ),
            ),
          );
        },
      ),
    );
  }
}
