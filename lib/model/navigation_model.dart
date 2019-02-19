import 'package:flutter/material.dart';

class NavigationModel{
  String title;
  IconData icon;
  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems=[
  NavigationModel(title: "Dashboard", icon: Icons.insert_chart),
  NavigationModel(title: "Dashboard", icon: Icons.insert_chart),
  NavigationModel(title: "Dashboard", icon: Icons.insert_chart),
  NavigationModel(title: "Notifications", icon: Icons.insert_chart),
  NavigationModel(title: "Settings", icon: Icons.insert_chart)
];
