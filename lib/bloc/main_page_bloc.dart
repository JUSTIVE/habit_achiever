import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../model/task_item.dart';

enum MainPageBlocEvent { addTask, removeTask }

class AddTaskEvent {
  AddTaskEvent({this.title, this.color});
  String title;
  Color color;
}

class MainPageBloc extends Bloc<AddTaskEvent, List<TaskItem>> {
  @override
  List<TaskItem> get initialState => List<TaskItem>();

  @override
  Stream<List<TaskItem>> mapEventToState(
      List<TaskItem> currentState, AddTaskEvent event) async* {
    if (event is AddTaskEvent)
      currentState.add(TaskItem(title: event.title, color: event.color));
  }
}
