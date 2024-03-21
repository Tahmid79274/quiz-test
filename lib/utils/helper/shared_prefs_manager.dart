import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static Future<void> setHighScore(int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('High Score', score);
  }

  static Future<int> getHighScore()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('High Score')??0;
  }
}
