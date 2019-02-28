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
                                  redrawer: widget.redrawer),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.check, color: Colors.grey.shade300),
            ),
          ),
        ],
      ),
    ]);
  }
}

class TaskListItemLongPressBottomSheet extends StatefulWidget {
  TaskListItemLongPressBottomSheet({@required this.id, this.redrawer});
  final int id;
  final Function redrawer;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 32),
          InkWell(
            onTap: () {
              print(widget.id.toString()+"삭제");
              setState(() {
                BlocProvider.of<MainPageBloc>(context)
                    .dispatch(RemoveTaskEvent(id: widget.id));
                widget.redrawer();
              });
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent.shade100,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('이 습관 삭제하기',
                    style: TextStyle(color: Colors.redAccent.shade100)),
              ],
            ),
          ),
          SizedBox(height: 32),
        ],
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
