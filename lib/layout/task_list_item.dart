import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/task_item.dart';

import '../bloc/main_page_bloc.dart';
import 'task_info_page.dart';

class TaskListItem extends StatefulWidget {
  TaskListItem({this.taskItem, this.redrawer});
  final Function redrawer;
  final TaskItem taskItem;
  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    MainPageBloc _mainPageBloc = BlocProvider.of<MainPageBloc>(context);
    return Flex(direction: Axis.vertical, children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: InkWell(
              splashColor: Colors.grey.shade100,
              onLongPress: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BlocProvider(
                        bloc: _mainPageBloc,
                        child: BottomSheet(
                          builder: (context) =>
                              TaskListItemLongPressBottomSheet(
                                id: widget.taskItem.id,
                                redrawer: widget.redrawer,
                                taskName: widget.taskItem.title,
                              ),
                          onClosing: () {},
                        )));
              },
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TaskInfoPage(
                          taskItem: widget.taskItem,
                        )));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: widget.taskItem.tasks.last.isDone
                              ? Colors.grey.shade300
                              : widget.taskItem.color,
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(widget.taskItem.title,
                            style: Theme.of(context).textTheme.body1),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(7, (int index) {
                              return RoutineToken(
                                  color: widget.taskItem.routine.routines[index]
                                      ? widget.taskItem.color
                                      : Colors.grey.shade200);
                            })),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _mainPageBloc.dispatch(TaskItemDoneEvent(id: widget.taskItem.id));
            },
            child: Container(
              height: 52,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.check, color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}

class TaskListItemLongPressBottomSheet extends StatefulWidget {
  TaskListItemLongPressBottomSheet(
      {@required this.id, this.redrawer, this.taskName});
  final int id;
  final Function redrawer;
  final String taskName;
  @override
  _TaskListItemLongPressBottomSheetState createState() =>
      _TaskListItemLongPressBottomSheetState();
}

class _TaskListItemLongPressBottomSheetState
    extends State<TaskListItemLongPressBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TaskListItemLongPressBottomSheetItem(
              text: '${widget.taskName} 수정하기',
              color: Colors.grey.shade400,
              icon: Icons.edit,
              action: () {
                print(widget.id.toString() + "편집");
                //TODO: 편집 화면 설정
                Navigator.pop(context);
              },
            ),
            TaskListItemLongPressBottomSheetItem(
              text: '${widget.taskName} 삭제하기',
              color: Colors.redAccent.shade100,
              icon: Icons.remove_circle,
              action: () {
                print(widget.id.toString() + "삭제");
                setState(() {
                  BlocProvider.of<MainPageBloc>(context)
                      .dispatch(RemoveTaskEvent(id: widget.id));
                  widget.redrawer();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListItemLongPressBottomSheetItem extends StatelessWidget {
  TaskListItemLongPressBottomSheetItem(
      {this.text, this.action, this.color, this.icon});
  final Color color;
  final Function action;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          action();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16, bottom: 12, top: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                width: 8,
              ),
              Text(text, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class RoutineToken extends StatelessWidget {
  RoutineToken({this.color});

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2),
      child: Container(
        width: 4,
        height: 4,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      ),
    );
  }
}
