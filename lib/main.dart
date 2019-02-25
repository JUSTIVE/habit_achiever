import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/main_page.dart';
import 'bloc/app_bloc.dart';
import 'bloc/util/bloc_provider.dart';

void main(){
  final appbloc = AppBloc();
  runApp(MyApp(appbloc));
}

class MyApp extends StatelessWidget {
  final AppBloc appBloc;
  
  MyApp(this.appBloc);

  @override
  Widget build(BuildContext context) {
    return NBlocProvider(
      bloc: appBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            canvasColor: Colors.transparent,
            primarySwatch: Colors.lightGreen,
            textTheme: TextTheme(
                title: TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                    fontWeight: FontWeight.w800),
                body1: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 14))),
        home: MainPage(),
      ),
    );
  }
}


// 노트북에서 커밋