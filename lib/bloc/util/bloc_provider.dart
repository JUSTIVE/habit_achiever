import 'package:flutter/material.dart';

import '../app_bloc.dart';

class NBlocProvider extends InheritedWidget {
  final AppBloc bloc;

  NBlocProvider({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(NBlocProvider) as NBlocProvider).bloc;
}