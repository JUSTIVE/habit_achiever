import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import '../model/task_item.dart';
import '../model/routine.dart';
import '../util/sharedPrefencer.dart';

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

class TaskItemDoneEvent extends TaskEvent {
  TaskItemDoneEvent({@required this.id});
  int id;
}

class TaskListState extends Equatable {
  final List<TaskItem> taskItems;
  final List<TaskItem> undoneItems;
  final List<TaskItem> doneItems;

  TaskListState({@required this.taskItems, this.undoneItems, this.doneItems})
      : super([taskItems, undoneItems]);
}

class MainPageBloc extends Bloc<TaskEvent, TaskListState> {
  @override
  TaskListState get initialState => TaskListState(
      taskItems: List<TaskItem>(),
      undoneItems: List<TaskItem>(),
      doneItems: List<TaskItem>());
 
  @override
  Stream<TaskListState> mapEventToState(
      TaskListState currentState, TaskEvent event) async* {
    List<TaskItem> temp = currentState.taskItems;

    if (event is AddTaskEvent) {
      temp.add(TaskItem(
          id: TaskItem.lastId++,
          title: event.title,
          color: event.color,
          routine: event.routine));
    } else if (event is RemoveTaskEvent) {
      temp.removeWhere((i) => i.id == event.id);
    } else if (event is TaskItemDoneEvent) {
      temp[event.id].tasks.last.isDone = true;
    }

    TaskListState value = TaskListState(
        taskItems: temp,
        undoneItems: temp
            .where((item) =>
                (!item.tasks.last.isDone) &&
                item.routine.routines[DateTime.now().weekday - 1])
            .toList(),
        doneItems: temp
            .where((item) =>
                (item.tasks.last.isDone) &&
                item.routine.routines[DateTime.now().weekday - 1])
            .toList());
    await SharedPreferenceAccesser.setTaskLists(jsonEncode(value.taskItems));
    yield value;
  }
}
