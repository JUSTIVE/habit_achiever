import 'task.dart';
import 'package:flutter/material.dart';
import 'routine.dart';

class TaskItem{
  TaskItem({@required this.title,@required this.color,@required this.routine});
  Color color;
  String title;
  List<Task> tasks;
  Routine routine;
}