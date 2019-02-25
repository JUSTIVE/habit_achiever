import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:habit_achiever/layout/task_list_item.dart';
import 'add_page.dart';
import 'component/column_builder.dart';
import '../model/task_item.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/main_page_progress_bloc.dart';
import '../bloc/util/bloc_provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageProgressBloc _mainPageProgressBloc;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _mainPageProgressBloc = MainPageProgressBloc();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _mainPageProgressBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _mainPageBloc = NBlocProvider.of(context).mainPageBloc;
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Stack(children: [
        BlocBuilder(
            bloc: _mainPageBloc,
            builder: (context, tasks) {
              return ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BlocBuilder(
                        bloc: _mainPageBloc,
                        builder: (context, tasks) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(height: 100),
                                Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('오늘 해야 할 습관')),
                                Material(
                                  color: Colors.white,
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: ColumnBuilder(
                                      itemCount: (tasks as List<TaskItem>)
                                          .where(
                                              (item) => !item.tasks.last.isDone)
                                          .where((item) =>
                                              item.routine.routines[
                                                  DateTime.now().weekday - 1])
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        List<TaskItem> listUndone =
                                            (tasks as List<TaskItem>).where(
                                                (item) =>
                                                    !item.tasks.last.isDone).toList();
                                        List<TaskItem> sortedlist = []
                                          ..addAll(listUndone.where((i) =>
                                              i.routine.routines[
                                                  DateTime.now().weekday - 1]))
                                          ;

                                        return TaskListItem(
                                            taskItem: sortedlist[index]);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('오늘 한 습관')),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "진행 상황",
                        style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        (_mainPageBloc.currentState.length == 0
                                    ? 0
                                    : (_mainPageProgressBloc.currentState *
                                        100 /
                                        _mainPageBloc.currentState.length))
                                .toInt()
                                .toString() +
                            "%",
                      )
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  value: _mainPageBloc.currentState.length == 0
                      ? 0
                      : (_mainPageProgressBloc.currentState *
                          100 /
                          _mainPageBloc.currentState.length),
                ),
              ]),
            ),
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPageBottomSheet(
                        mainPageBloc: _mainPageBloc,
                      )));
        },
        child: Hero(
          tag: "addbutton",
          child: Icon(
            Icons.add,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}
