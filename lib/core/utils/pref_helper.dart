import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  static SharedPreferences? _prefs;
  //  ensure only one instance of SharedPreferences is used
  static Future<SharedPreferences> get _instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  //* Token Management
  static Future<void> saveToken(String token) async {
    await _setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    return await _getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    await _remove(_tokenKey);
  }
    static Future<void> saveRefreshToken(String token) async {
    await _setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    return await _getString(_refreshTokenKey);
  }

  static Future<void> clearRefreshToken() async {
    await _remove(_refreshTokenKey);
  }

  // Private helpers — add all future keys through these
  static Future<void> _setString(String key, String value) async {
    final prefs = await _instance;
    await prefs.setString(key, value);
  }

  static Future<String?> _getString(String key) async {
    final prefs = await _instance;
    return prefs.getString(key);
  }

  static Future<void> _remove(String key) async {
    final prefs = await _instance;
    await prefs.remove(key);
  }
}
