import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage();
  // store 实例
  SharedPreferences? instance;

  getInstance() async {
    instance ??= await SharedPreferences.getInstance();
    return instance;
  }

}