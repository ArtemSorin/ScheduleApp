import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchDataWithoutParams(int group) async {
  final response = await http.get(
      Uri.parse('https://ictis.ru/api?request=schedule&group=$group.html'));

  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    return userMap;
  } else {
    throw Exception('Failed to load CoinsList');
  }
}

Future<Map<String, dynamic>> fetchData(int group, int week) async {
  final response = await http.get(Uri.parse(
      'https://ictis.ru/api?request=schedule&group=$group.html&week=$week'));

  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    return userMap;
  } else {
    throw Exception('Failed to load CoinsList');
  }
}

class Schedule {
  Schedule({
    required this.table,
    required this.weeks,
  });

  TableSh table;
  List<int> weeks;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        table: TableSh.fromJson(json["table"]),
        weeks: List<int>.from(json["weeks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "table": table.toJson(),
        "weeks": List<dynamic>.from(weeks.map((x) => x)),
      };
}

class TableSh {
  TableSh({
    required this.type,
    required this.name,
    required this.week,
    required this.group,
    required this.table,
    required this.link,
  });

  String type;
  String name;
  int week;
  String group;
  List<List<String>> table;
  String link;

  factory TableSh.fromJson(Map<String, dynamic> json) => TableSh(
        type: json["type"],
        name: json["name"],
        week: json["week"],
        group: json["group"],
        table: List<List<String>>.from(
            json["table"].map((x) => List<String>.from(x.map((x) => x)))),
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "week": week,
        "group": group,
        "table": List<dynamic>.from(
            table.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "link": link,
      };
}
