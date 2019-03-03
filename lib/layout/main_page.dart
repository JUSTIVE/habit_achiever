import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'task_list_item.dart';
import 'add_page.dart';
import '../bloc/main_page_progress_bloc.dart';
import '../bloc/main_page_bloc.dart';
import 'dart:ui';

import '../model/task_item.dart';
import '../model/routine.dart';


class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageProgressBloc _mainPageProgressBloc;
  final MainPageBloc _mainPageBloc = MainPageBloc();
  ScrollController _scrollController;
  static int k = 0;
  @override
  void initState() {
    super.initState();
    _mainPageProgressBloc = MainPageProgressBloc();
    _scrollController = ScrollController();
  }

  void redraw() {
    setState(() {});
  }

  @override
  void dispose() {
    _mainPageProgressBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Stack(children: [
        ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 60),
                      Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('오늘 해야 할 습관')),
                      Material(
                        color: Colors.white,
                        elevation: 1,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: StreamBuilder(
                              stream: _mainPageBloc.state,
                              builder: (context,
                                  AsyncSnapshot<TaskListState> blocState) {
                                if (blocState.data is TaskListState)
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            blocState.data.undoneItems.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return BlocProvider(
                                            bloc: _mainPageBloc,
                                            child: TaskListItem(
                                                taskItem: blocState
                                                    .data.undoneItems[index],
                                                redrawer: redraw),
                                          );
                                        },
                                      ),
                                      Container(
                                        child: Text(blocState
                                                .data.taskItems.length
                                                .toString() +
                                            ", vis:" +
                                            blocState.data.undoneItems.length
                                                .toString()),
                                      )
                                    ],
                                  );
                                else {
                                  return Container(
                                    child: Text(blocState.data == null
                                        ? '0'
                                        : blocState.data.taskItems.length
                                            .toString()),
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(12), child: Text('오늘 한 습관')),
                      Material(
                        color: Colors.white,
                        elevation: 1,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: StreamBuilder(
                              stream: _mainPageBloc.state,
                              builder: (context,
                                  AsyncSnapshot<TaskListState> blocState) {
                                if (blocState.data is TaskListState)
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            blocState.data.doneItems.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return BlocProvider(
                                            bloc: _mainPageBloc,
                                            child: TaskListItem(
                                                taskItem: blocState
                                                    .data.doneItems[index],
                                                redrawer: redraw),
                                          );
                                        },
                                      ),
                                      Container(
                                        child: Text(blocState
                                                .data.taskItems.length
                                                .toString() +
                                            ", don:" +
                                            blocState.data.doneItems.length
                                                .toString()),
                                      )
                                    ],
                                  );
                                else {
                                  return Container(
                                    child: Text(blocState.data == null
                                        ? '0'
                                        : blocState.data.taskItems.length
                                            .toString()),
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Container(
            height: 48,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: BlocBuilder(
                    bloc: _mainPageBloc,
                    builder: (context, bloc) {
                      if (bloc is TaskListState) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              height: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: (bloc.undoneItems.length +
                                              bloc.doneItems.length ==
                                          0
                                      ? 0
                                      : (bloc.doneItems.length /
                                          (bloc.undoneItems.length +
                                              bloc.doneItems.length))),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Text(
                                    (bloc.undoneItems.length +
                                                        bloc.doneItems.length ==
                                                    0
                                                ? 0
                                                : (bloc.doneItems.length *
                                                    100 /
                                                    (bloc.undoneItems.length +
                                                        bloc.doneItems.length)))
                                            .toInt()
                                            .toString() +
                                        "%",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white)),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
              ),
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
          // Routine routineDummy = Routine.fromJson(jsonDecode(""));
          

          TaskItem dummy =TaskItem.fromJson({
        "id": 816,
        "title": "되면좋겠다",
        "color": "Color(0xffe57373)",
        "routine": "[true,true,true,true,true,true,true]",
        "tasks": "[{\"date\":\"[2019-03-04 02:52:17.502853]\",\"isDone\":false}]"
    });
          String result = dummy!=null?"됨!":"안됨!";
          print(result);

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
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
