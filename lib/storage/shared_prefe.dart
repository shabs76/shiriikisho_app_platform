import 'package:shared_preferences/shared_preferences.dart';

class DriverPrefences {
  static SharedPreferences? _preferences;

  static const String logKey = 'logkey';
  static const String logSess = 'logsess';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLoggedinDetails(
      {required String logey, required String logess}) async {
    await _preferences!.setString(logKey, logey);
    await _preferences!.setString(logSess, logess);
  }

  static Map<String, dynamic> getLoggedinDetails() {
    final String? keyx = _preferences!.getString(logKey);
    final String? sess = _preferences!.getString(logSess);
    Map<String, dynamic> ans = {
      logKey: keyx,
      logSess: sess,
    };
    return ans;
  }

  static void removeLoggedinDetails() {
    _preferences!.remove(logKey);
    _preferences!.remove(logSess);
  }
}
