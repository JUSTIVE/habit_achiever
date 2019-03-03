import 'package:flutter/foundation.dart';
import 'Date.dart';
import 'dart:convert';

class Task{
  Task({@required this.date,this.isDone=false});

  Date date;
  bool isDone;

  Task.fromJson(Map<String,dynamic> json)
  :date = json['date'],
  isDone = json['isDone'];

  Map<String, dynamic> toJson()=>{
    'date':date.toString(),
    'isDone':isDone
  };
}