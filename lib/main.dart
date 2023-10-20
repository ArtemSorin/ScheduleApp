import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetable/screens/home.dart';
import 'package:timetable/screens/notes.dart';
import 'package:timetable/screens/teachers.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        statusBarColor: const Color.fromARGB(255, 91, 117, 240),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            const Home(),
            const Teachers(),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.school_rounded,
                size: 56,
                color: Colors.blue[400],
              ),
            ),
            const Notes(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.calendar_month_rounded,
              outlinedIcon: Icons.calendar_month_outlined,
            ),
            BarItem(
              filledIcon: Icons.people,
              outlinedIcon: Icons.people_alt_outlined,
            ),
            BarItem(
              filledIcon: Icons.school_rounded,
              outlinedIcon: Icons.school_outlined,
            ),
            BarItem(filledIcon: Icons.task, outlinedIcon: Icons.task_outlined),
          ],
        ),
      ),
    );
  }
}
