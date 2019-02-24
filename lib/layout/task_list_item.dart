import 'package:flutter/material.dart';
import '../model/task_item.dart';
import 'task_info_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/main_page_bloc.dart';

class TaskListItem extends StatefulWidget {
  TaskListItem({this.taskItem});
  final TaskItem taskItem;
  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey.shade100,
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
                  builder: (context) =>
                      TaskListItemLongPressBottomSheet(id: widget.taskItem.id),
                  onClosing: () {},
                ));
      },
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 24,
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: widget.taskItem.color,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Text(widget.taskItem.title,
                    style: Theme.of(context).textTheme.body1)),
            // Container(
            //   color: Colors.grey.shade100,
            //   width: 200,
            //   height: 36,
            // ),
            Icon(Icons.check, color: Colors.grey.shade300),
            SizedBox(width: 32)
          ],
        ),
      ),
    );
  }
}

class TaskListItemLongPressBottomSheet extends StatelessWidget {
  TaskListItemLongPressBottomSheet({@required this.id});
  final int id;
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
              print("삭제");
              BlocProvider.of<MainPageBloc>(context).dispatch(RemoveTaskEvent());
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
