import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/lists.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String str;

  const MyAppBar({Key? key, required this.str}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: IconButton(
        color: lightBlue,
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
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: lightBlue),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      'OK',
                      style: TextStyle(color: lightBlue),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.question_mark),
          color: lightBlue,
        )
      ],
      title: Text(
        str,
        style: TextStyle(color: lightBlue),
      ),
      centerTitle: true,
    );
  }
}
