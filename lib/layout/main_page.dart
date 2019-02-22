import 'package:flutter/material.dart';
import '../bloc/main_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_achiever/model/task_item.dart';
import 'package:habit_achiever/layout/task_list_item.dart';
import 'add_page.dart';
import 'component/circulardottedGraph.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainPageBloc _mainPageBloc;

  @override
  void initState() {
    super.initState();

    _mainPageBloc = MainPageBloc();
  }

  @override
  void dispose() {
    _mainPageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Text(
              "오늘의 할일들",
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.start,
            ),
          ),
          CircularDottedGraph(
            value: 50,
            precision: 2,
          ),
          Expanded(
            child: BlocBuilder(
              bloc: _mainPageBloc,
              builder: (context, tasks) {
                return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (tasks as List<TaskItem>).length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskListItem(taskItem: tasks[index]);
                  },
                );
              },
            ),
          ),
          // Container(
          //   height: 300,
          //   decoration: BoxDecoration(
          //       color: Colors.pink.shade400,
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(24),
          //           topRight: Radius.circular(24))),
          // )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
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
