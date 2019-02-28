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
  GlobalKey _scaffoldKey = GlobalKey();
  int currentColorScheme = 0;
  final List<Color> colorSchemes = [
    Colors.red.shade300,
    Colors.orange.shade300,
    Colors.yellow.shade400,
    Colors.greenAccent.shade100,
    Colors.lightBlueAccent.shade100,
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
      key: _scaffoldKey,
      body: Stack(children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 32),
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
                        height: 56,
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
                                margin: EdgeInsets.only(
                                    top: 8, bottom: 8, right: 12),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: colorSchemes[index],
                                    borderRadius: BorderRadius.circular(24)),
                                child: (index == currentColorScheme)
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Container(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text('루틴'),
                      Container(
                        height: 80,
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
                                      if (currentRoutine.setValue(index) == 1) {
                                        (_scaffoldKey.currentState
                                                as ScaffoldState)
                                            .showSnackBar(SnackBar(
                                          content: Text('하루 이상은 반복해야 합니다'),
                                        ));
                                      }
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: 8, bottom: 8, right: 12),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Material(
                                        elevation:
                                            currentRoutine.routines[index]
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
                                    const SizedBox(
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
              ],
            ),
          ),
        ),
        Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Hero(tag: "addbutton", child: Icon(Icons.add)),
                    onPressed: () async {
                      if (tec.text.trim() != "") {
                        widget.mainPageBloc.dispatch(AddTaskEvent(
                            title: tec.text,
                            color: colorSchemes[currentColorScheme],
                            routine: currentRoutine));
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.pop(context);
                      } else {
                        (_scaffoldKey.currentState as ScaffoldState)
                            .showSnackBar(SnackBar(
                          content: Text('이름을 입력해야 합니다'),
                        ));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
