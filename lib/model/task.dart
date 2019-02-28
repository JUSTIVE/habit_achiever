import 'package:flutter/foundation.dart';
import 'Date.dart';

class Task{
  Date date;
  bool isDone;

  Task({@required this.date,this.isDone=false});
}