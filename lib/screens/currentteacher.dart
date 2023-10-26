import 'package:flutter/material.dart';
import '../models/appbar.dart';

class CurrentTeacher extends StatelessWidget {
  const CurrentTeacher({
    super.key,
    required this.title,
    required this.image,
    required this.post,
    required this.mail,
  });

  final String title;
  final String image;
  final String post;
  final String mail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(str: 'Сотрудники'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  Card(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipOval(
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 10, right: 10, bottom: 0),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 91, 117, 240),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 10, right: 10, bottom: 0),
                                child: Text(
                                  post,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Контактная информация:',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 91, 117, 240),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Text(mail),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 0, right: 5, bottom: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return const Color.fromARGB(
                                      255, 91, 117, 240);
                                },
                              ),
                            ),
                            child: const Text('Написать'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
