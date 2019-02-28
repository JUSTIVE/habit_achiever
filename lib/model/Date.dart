import 'package:equatable/equatable.dart';

class Date extends Equatable {
  Date(DateTime dateTime) : super([dateTime]) {
    this.dateTime = dateTime;
  }
  DateTime dateTime;
  int year;
  int month;
  int day;
}
