import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginUser(String username) async {
    try {
      SharedPreferences sharedPrefs = await _prefs;
      sharedPrefs.setString('username', username);
    } catch (e) {
      print(e);
    }
  }

  void logoutUser() async {
    SharedPreferences sharedPrefs = await _prefs;
    sharedPrefs.clear();
  }

  Future<String?> getUsername() async {
    SharedPreferences sharedPrefs = await _prefs;
    sharedPrefs.getString('username');
  }
}
