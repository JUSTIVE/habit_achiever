import 'task.dart';
import 'package:flutter/material.dart';
import 'routine.dart';

class TaskItem {
  TaskItem(
      {@required this.id,
      @required this.title,
      @required this.color,
      @required this.routine})
      : tasks = List<Task>()
      ..add(Task(date: DateTime.now()));
  static int lastId = 0;
  int id;
  Color color;
  String title;
  List<Task> tasks;
  Routine routine;

  String toString() {
    return this.id.toString() + " " + title;
  }
}
