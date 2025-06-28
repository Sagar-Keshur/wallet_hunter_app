import 'package:shared_preferences/shared_preferences.dart';

import '../../dependency_manager/dependency_manager.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper({SharedPreferences? sharedPreferences})
    : _sharedPreferences = sharedPreferences ?? getIt<SharedPreferences>();

  final SharedPreferences _sharedPreferences;

  static const String _userId = 'userId';
  static const String _email = 'email';
  static const String _loginState = 'loginState';
  static const String _basicInfo = 'basicInfo';

  Future<void> setUserId(String userId) async {
    await _sharedPreferences.setString(_userId, userId);
  }

  String getUserId() {
    return _sharedPreferences.getString(_userId) ?? '';
  }

  Future<void> setEmail(String? email) async {
    if (email == null || email.isEmpty) {
      return;
    }
    await _sharedPreferences.setString(_email, email);
  }

  String getEmail() {
    return _sharedPreferences.getString(_email) ?? '';
  }

  Future<void> setLoginStateTrue() async {
    await _sharedPreferences.setBool(_loginState, true);
  }

  Future<void> setLoginStateFalse() async {
    await _sharedPreferences.setBool(_loginState, false);
  }

  bool getLoginState() {
    return _sharedPreferences.getBool(_loginState) ?? false;
  }

  Future<void> setBasicInfoStateTrue() async {
    await _sharedPreferences.setBool(_basicInfo, true);
  }

  Future<void> setBasicInfoStateFalse() async {
    await _sharedPreferences.setBool(_basicInfo, false);
  }

  bool getBasicInfoState() {
    return _sharedPreferences.getBool(_basicInfo) ?? false;
  }

  Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }
}
