import '../bloc/main_page_bloc.dart';
import 'package:flutter/material.dart';

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
  ];
  TextEditingController tec = TextEditingController();
  @override
  void initState() {
    currentColorScheme = 0;
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
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("새 습관 추가", style: Theme.of(context).textTheme.title),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 80,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: colorSchemes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentColorScheme = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 48,
                              width: 48,
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
                    )
                  ],
                ),
              ),
              Center(
                child: FlatButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    widget.mainPageBloc.dispatch(AddTaskEvent(
                        title: tec.text,
                        color: colorSchemes[currentColorScheme]));
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
