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
      ..add(Task(date: Date(DateTime.now())));

  TaskItem.fromJson(Map<String,dynamic> json)
    :id=json['id'],
    color=json['color'],
    title=json['title'],
    tasks=json['tasks'],
    routine= json['routine'];
  
  Map<String, dynamic> toJson()=>
  {
    'id':id,
    'title':title,
    'color':color.toString(),
    'routine':jsonEncode(routine),
    'tasks':tasks.map((i)=>jsonEncode(i)).toList()
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
