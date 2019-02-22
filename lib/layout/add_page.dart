import '../bloc/main_page_bloc.dart';
import 'package:flutter/material.dart';
import '../model/routine.dart';

class MainPageBottomSheet extends StatefulWidget {
  MainPageBottomSheet({this.mainPageBloc});
  final MainPageBloc mainPageBloc;
  @override
  _MainPageBottomSheetState createState() => _MainPageBottomSheetState();
}

class _MainPageBottomSheetState extends State<MainPageBottomSheet> {
  int currentColorScheme = 0;
  final List<Color> colorSchemes = [
    Colors.red.shade300,
    Colors.orange.shade300,
    Colors.yellow.shade300,
    Colors.greenAccent.shade100,
    Colors.indigoAccent.shade100,
    Colors.pink.shade200
  ];
  final List<String> days = ["월", "화", "수", "목", "금", "토", "일"];
  Routine currentRoutine;
  TextEditingController tec = TextEditingController();
  @override
  void initState() {
    currentColorScheme = 0;
    currentRoutine = Routine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 32),
                ],
              ),
              Text("새 습관 추가", style: Theme.of(context).textTheme.title),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 32,
                    ),
                    Text("이름"),
                    TextField(
                      controller: tec,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text("색상"),
                    Container(
                      height: 65,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        itemCount: colorSchemes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentColorScheme = index;
                              });
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 8, bottom: 8, right: 16),
                              height: 48,
                              width: 36,
                              decoration: BoxDecoration(
                                  color: colorSchemes[index],
                                  borderRadius: BorderRadius.circular(24)),
                              child: (index == currentColorScheme)
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : Container(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text('루틴'),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    currentRoutine.routines[index] =
                                        !currentRoutine.routines[index];
                                  });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: 8, bottom: 8, right: 16),
                                    height: 48,
                                    width: 36,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Material(
                                      elevation: currentRoutine.routines[index]
                                          ? 2
                                          : 0,
                                      color: currentRoutine.routines[index]
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(24),
                                      child: Icon(
                                        Icons.check,
                                        color: currentRoutine.routines[index]
                                            ? Colors.grey.shade300
                                            : Colors.white,
                                      ),
                                    )),
                              ),
                              Center(
                                  child: Row(
                                children: <Widget>[
                                  Text(days[index]),
                                  SizedBox(
                                    width: 16,
                                  )
                                ],
                              ))
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: FlatButton(
                  child: Hero(tag: "addbutton", child: Icon(Icons.add)),
                  onPressed: () {
                    widget.mainPageBloc.dispatch(AddTaskEvent(
                        title: tec.text,
                        color: colorSchemes[currentColorScheme]));
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
