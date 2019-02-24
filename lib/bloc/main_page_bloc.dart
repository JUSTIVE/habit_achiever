import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../model/task_item.dart';
import '../model/routine.dart';

abstract class TaskEvent{}

class AddTaskEvent extends TaskEvent{
  AddTaskEvent({this.title, this.color,this.routine});
  String title;
  Color color;
  Routine routine;
}
class RemoveTaskEvent extends TaskEvent{
  int id;
}

class MainPageBloc extends Bloc<TaskEvent, List<TaskItem>> {
  @override
  List<TaskItem> get initialState => List<TaskItem>();

  @override
  Stream<List<TaskItem>> mapEventToState(
      List<TaskItem> currentState, TaskEvent event) async* {
    if (event is AddTaskEvent){
      currentState.add(TaskItem(id:TaskItem.lastId++,title: event.title, color: event.color, routine: event.routine));
      print(this.state);
    }
    else if(event is RemoveTaskEvent){
      currentState.removeWhere((i)=>i.id==event.id);
    }
  }
}
