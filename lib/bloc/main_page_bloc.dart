import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../model/task_item.dart';
import '../model/routine.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  AddTaskEvent(
      {@required this.title, @required this.color, @required this.routine});
  String title;
  Color color;
  Routine routine;
}

class RemoveTaskEvent extends TaskEvent {
  RemoveTaskEvent({@required this.id});
  int id;
}

class MainPageBloc extends Bloc<TaskEvent, List<TaskItem>> {
  @override
  List<TaskItem> get initialState => List<TaskItem>();

  @override
  Stream<List<TaskItem>> mapEventToState(
      List<TaskItem> currentState, TaskEvent event) async* {
    print(currentState[currentState.length - 1].toString() + "생성");
    if (event is AddTaskEvent) {
      currentState.add(TaskItem(
          id: TaskItem.lastId++,
          title: event.title,
          color: event.color,
          routine: event.routine));
      print(currentState[currentState.length - 1].toString() + "생성");
      print(DateTime.now().weekday.toString());
      print(this.state);
    } else if (event is RemoveTaskEvent) {
      print(currentState.where((i) => i.id == event.id).toList()[0].toString() + "삭제 중");
      currentState.removeWhere((i) => i.id == event.id);
    }
  }
}
