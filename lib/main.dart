import 'package:flutter/material.dart';
import 'layout/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor:  Colors.transparent,
        primarySwatch: Colors.lightGreen,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 24,
            color: Colors.black87,
            fontWeight: FontWeight.w800
          ),
          body1: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 14
          )
        )

        
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

