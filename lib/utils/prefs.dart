import 'package:flicklist/constants/user_constants.dart';
import 'package:flicklist/utils/shared_preference_helper.dart';

class Prefs {
  static Future setApiToken(String value) =>
      PreferencesHelper.setString(API_TOKEN, value);

  static Future<String> get apiToken =>
      PreferencesHelper.getString(API_TOKEN);

  static Future<String> get userName =>
      PreferencesHelper.getString(USER_NAME);

  static Future setUserName(String value) =>
      PreferencesHelper.setString(USER_NAME, value);

  static Future<String> get userEmail =>
      PreferencesHelper.getString(USER_EMAIL);

  static Future setUserEmail(String value) =>
      PreferencesHelper.setString(USER_EMAIL, value);

  static Future<String> get userId => PreferencesHelper.getString(USER_ID);

  static Future setUserId(String value) =>
      PreferencesHelper.setString(USER_ID, value);

  static Future<void> clear() async {
    await Future.wait(
        <Future>[setUserName(''), setUserId(''), setApiToken('')]);
  }
}
