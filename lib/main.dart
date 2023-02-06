import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:timetable/screens/listweeks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  List<String?> weekcolors = [];

  void initstate() {
    super.initState();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://ictis.ru/8.html');
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);

    final imgColors = html
        .querySelectorAll('body > div.container > a')
        .map((element) => element.attributes['style'])
        .toList();

    if (!mounted) return;

    setState(() {
      weekcolors = imgColors;
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
        title: const Text(
          'Главная',
          style: TextStyle(color: Color.fromARGB(255, 91, 117, 240)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const ListTile(
            title: Text(
              '1 курс',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                            index: 7,
                            name: 'КТбо1-7',
                            colors: weekcolors,
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
                            index: 8,
                            name: 'КТбо1-8',
                            colors: weekcolors,
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
                            index: 9,
                            name: 'КТбо1-9',
                            colors: weekcolors,
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
                            index: 10,
                            name: 'КТбо1-10',
                            colors: weekcolors,
                          )),
                );
              },
            ),
          ),
          const ListTile(
            title: Text(
              '2 курс',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                            index: 53,
                            name: 'КТбо2-7',
                            colors: weekcolors,
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
                            index: 54,
                            name: 'КТбо2-8',
                            colors: weekcolors,
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
                            index: 55,
                            name: 'КТбо2-9',
                            colors: weekcolors,
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
                            index: 56,
                            name: 'КТбо2-10',
                            colors: weekcolors,
                          )),
                );
              },
            ),
          ),
          const ListTile(
            title: Text(
              '3 курс',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                            index: 100,
                            name: 'КТбо3-7',
                            colors: weekcolors,
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
                            index: 101,
                            name: 'КТбо3-8',
                            colors: weekcolors,
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
                            index: 102,
                            name: 'КТбо3-9',
                            colors: weekcolors,
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
                            index: 103,
                            name: 'КТбо3-10',
                            colors: weekcolors,
                          )),
                );
              },
            ),
          ),
          const ListTile(
            title: Text(
              '4 курс',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                            index: 130,
                            name: 'КТбо4-7',
                            colors: weekcolors,
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
                            index: 131,
                            name: 'КТбо4-8',
                            colors: weekcolors,
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
                            index: 132,
                            name: 'КТбо4-9',
                            colors: weekcolors,
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
                            index: 133,
                            name: 'КТбо4-10',
                            colors: weekcolors,
                          )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
