import 'task.dart';
import 'package:flutter/material.dart';
class TaskItem{
  TaskItem({@required this.title,@required this.color});
  Color color;
  String title;
  List<Task> tasks;
}