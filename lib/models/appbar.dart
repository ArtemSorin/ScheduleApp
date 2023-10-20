import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String str;

  const MyAppBar({Key? key, required this.str}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30.0),
        ),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 91, 117, 240),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          leading: IconButton(
            color: Colors.white,
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
                        'Для удобства расписание текущей недели и дня выделено цветом.'),
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
              color: Colors.white,
            )
          ],
          title: Text(
            str,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
