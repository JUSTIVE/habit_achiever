import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceAccesser{
  static final String _kTaskList = "tasklists";

  static Future<String> getTaskLists() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kTaskList)??"";
  }

  static Future<bool> setTaskLists(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kTaskList,value);
  }
}