
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BRS extends StatelessWidget {
  const BRS({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebviewScaffold(url: 'https://grade.sfedu.ru/'),
    );
  }
}