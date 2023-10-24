import 'package:flutter/material.dart';

import '../models/appbar.dart';

class BRS extends StatelessWidget {
  const BRS({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BRSPage(),
    );
  }
}

class BRSPage extends StatefulWidget {
  const BRSPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<BRSPage> createState() => _BRSPageState();
}

class _BRSPageState extends State<BRSPage> {
  List<String> listScores = [
    '—',
    '21%',
    '—',
    '0%',
    '—',
    '—',
    '—',
    '—',
    '10%',
    '—'
  ];
  List<String> listTitles = [
    'Искусственный интеллект и анализ данных',
    'Методы оптимизации',
    'Разработка мобильных приложений',
    'Безопасность жизнедеятельности',
    'Иностранный язык для деловой коммуникации',
    'Творческий проект',
    'Элективные дисциплины по физической культуре и спорту',
    'Архитектура, технологии и инструментальные средства разработки программного обеспечения',
    'Инженерия программного обеспечения для систем реального времени и Интернета вещей',
    'Учебная практика, ознакомительная практика'
  ];
  List<String> listTypes = [
    'Экзамен',
    'Экзамен',
    'Экзамен',
    'Зачет',
    'Зачет',
    'Зачет',
    'Зачет',
    'Дифф. зачет',
    'Дифф. зачет',
    'Дифф. зачет'
  ];
  List<String> listCurrentScores = [
    '0 / 0 / 100',
    '13 / 60 / 100',
    '0 / 0 / 100',
    '0 / 15 / 100',
    '0 / 0 / 100',
    '0 / 0 / 100',
    '0 / 0 / 100',
    '0 / 0 / 100',
    '10 / 100 / 100',
    '0 / 0 / 100',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(str: 'Предметы'),
        body: listTitles.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: listTitles.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 91, 117, 240),
                      child: Text(listScores[i]),
                    ),
                    title: Text(
                      listTitles[i],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    subtitle: Text(listCurrentScores[i]),
                    trailing: Text(listTypes[i]),
                  );
                },
              ));
  }
}
