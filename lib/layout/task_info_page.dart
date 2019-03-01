import 'package:flutter/material.dart';
import '../model/task_item.dart';
import '../model/Date.dart';
import 'package:flutter/scheduler.dart';

class TaskInfoPage extends StatefulWidget {
  TaskInfoPage({this.taskItem});
  final TaskItem taskItem;
  @override
  _TaskInfoPageState createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage>
    with TickerProviderStateMixin {
  AnimationController _gaugeAnimationController;
  Animation<double> _gaugeAnimation;

  @override
  void initState() {
    super.initState();
    _gaugeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _gaugeAnimation = CurvedAnimation(
        curve: Curves.easeOut, parent: _gaugeAnimationController);

    SchedulerBinding.instance
        .addPostFrameCallback((_) => _gaugeAnimationController.forward());
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        color: Colors.white,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 32),
            Text(
              widget.taskItem.title,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .merge(TextStyle(fontWeight: FontWeight.w900)),
            ),
            SizedBox(
              height: 32,
            ),
            AnimatedBuilder(
              animation: _gaugeAnimation,
              builder: (BuildContext context, Widget child) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade100,
                          value: _gaugeAnimation.value * 50 / 100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              widget.taskItem.color),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text((_gaugeAnimation.value * 50).round().toString())
                  ],
                );
              },
            ),
            AnimatedBuilder(
              animation: _gaugeAnimation,
              builder: (BuildContext context, Widget child) {
                return GridDotCalendar(
                  animationValue: _gaugeAnimation.value,
                );
              },
            )
          ],
        ),
      )
    ]));
  }
}

class GridDotCalendar extends StatefulWidget {
  GridDotCalendar({this.animationValue});
  final double animationValue;
  @override
  State<StatefulWidget> createState() => GridDotCalendarState();
}

class GridDotCalendarState extends State<GridDotCalendar> {
  @override
  Widget build(BuildContext context) {
    return Row(

    );
  }
}

class GridDotWeekItem extends StatefulWidget {
  Date startDate;
  @override
  _GridDotWeekItemState createState() => _GridDotWeekItemState();
}

class _GridDotWeekItemState extends State<GridDotWeekItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
