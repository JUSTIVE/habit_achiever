import 'task.dart';
import 'package:flutter/material.dart';
import 'routine.dart';
import 'dart:convert';

class TaskItem {
  TaskItem(
      {@required this.id,
      @required this.title,
      @required this.color,
      @required this.routine})
      : tasks = List<Task>()
      ..add(Task(date: DateTime.now()));

  TaskItem.fromJson(Map<String,dynamic> json)
    :id=json['id'],
    color=json['color'],
    title=json['title'],
    tasks=json['tasks'],
    routine= json['routine'];
  
  static int lastId = 0;
  int id;
  Color color;
  String title;
  List<Task> tasks;
  Routine routine;

  String toString() {
    return jsonEncode(this);
  }
  
}
