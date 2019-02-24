import 'task.dart';
import 'package:flutter/material.dart';
import 'routine.dart';

class TaskItem{
  TaskItem({@required this.id,@required this.title,@required this.color,@required this.routine});
  static int lastId=0;
  int id;
  Color color;
  String title;
  List<Task> tasks;
  Routine routine;
}