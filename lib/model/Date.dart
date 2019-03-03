import 'package:equatable/equatable.dart';

class Date extends Equatable {
  Date({int year, int month, int day}) : super([year,month,day]) {
    this.year = year;
    this.month = month;
    this.day= day;
  }
  Date.fromJson(Map<String,dynamic> json)
  :year= json['year'],
  month= json['month'],
  day= json['day'];

  Map<String,int> toJson()=>{
    'year':year,
    'month':month,
    'day':day
  };

  int year;
  int month;
  int day;
}
