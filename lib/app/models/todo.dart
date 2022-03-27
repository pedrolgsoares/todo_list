import 'dart:convert';

class Todo {
  String title;
  DateTime dateTime;

  Todo({required this.title, required this.dateTime});
  

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String()
    };
  } 

  Todo.fromJson(Map<String, dynamic> json)
    : title = json['title'] ?? '',
      dateTime = DateTime.parse(json['dateTime']);

}
