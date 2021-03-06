import 'task.dart';
import 'package:flutter/material.dart';
import 'routine.dart';
import 'dart:convert';

import 'Date.dart';

class TaskItem {
  TaskItem(
      {@required this.id,
      @required this.title,
      @required this.color,
      @required this.routine})
      : tasks = List<Task>()
          ..add(Task(
              date: Date(
                  year: DateTime.now().year,
                  month: DateTime.now().month,
                  day: DateTime.now().day)));

  TaskItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        color = Color(
            int.parse((json['color'] as String).substring(8, 16), radix: 16)),
        title = json['title'],
        tasks = (jsonDecode(json['tasks']) as List<dynamic>)
            .map((x) => Task.fromJson(x))
            .toList(),
        routine = Routine.fromJson(jsonDecode(json['routine']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'color': color.toString(),
        'routine': jsonEncode(routine),
        'tasks': tasks.map((i) => jsonEncode(i)).toList().toString()
      };

  static int lastId = 0;
  int id;
  Color color;
  String title;
  List<Task> tasks;
  Routine routine;

  String toString() {
    print("in");
    return jsonEncode(this);
  }
}
