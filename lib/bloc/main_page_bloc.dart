import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../model/task_item.dart';
import '../model/routine.dart';
import 'package:equatable/equatable.dart';

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

class TaskListState extends Equatable {
  final List<TaskItem> taskItems;
  final List<TaskItem> visibleItems;
  TaskListState({@required this.taskItems, this.visibleItems})
      : super([taskItems,visibleItems]);
}

class TaskListUpdated extends TaskListState {
  final List<TaskItem> visibleItems;
  TaskListUpdated(List<TaskItem> taskItems, this.visibleItems)
      : super(taskItems: taskItems);
}

class MainPageBloc extends Bloc<TaskEvent, TaskListState> {
  @override
  TaskListState get initialState => TaskListState(
      taskItems: List<TaskItem>(), visibleItems: List<TaskItem>());

  @override
  Stream<TaskListState> mapEventToState(
      TaskListState currentState, TaskEvent event) async* {
    if (event is AddTaskEvent) {
      List<TaskItem> temp = currentState.taskItems;
      temp.add(TaskItem(
          id: TaskItem.lastId++,
          title: event.title,
          color: event.color,
          routine: event.routine));
      yield TaskListState(
          taskItems: temp,
          visibleItems: temp//.where((item) =>
              // !item.tasks.last.isDone &&
              //item.routine.routines[DateTime.now().weekday - 1])
          );
    } else if (event is RemoveTaskEvent) {
      List<TaskItem> temp = currentState.taskItems;
      temp.removeWhere((i) => i.id == event.id);
      yield TaskListState(
          taskItems: temp,
          visibleItems: temp//.where((item) =>
              // !item.tasks.last.isDone &&
              //item.routine.routines[DateTime.now().weekday - 1])
          );
    }
  }
}
