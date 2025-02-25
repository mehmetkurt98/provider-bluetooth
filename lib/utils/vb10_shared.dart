import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static SharedManager? _instance;
  SharedPreferences? _preferences;

  SharedManager._();

  static Future<void> initSharedPrefences() async {
    if (_instance?._preferences != null) return;
    _instance = SharedManager._();
    _instance!._preferences = await SharedPreferences.getInstance();
  }

  static SharedManager get instance {
    if (_instance != null) {
      return _instance!;
    }
    throw Exception("SharedPreferences not initialized.");
  }

  Future<bool> setStringValue(String key, String value) async {
    return await _preferences?.setString(key, value) ?? false;
  }

  String? getStringValue(String key) {
    return _preferences?.getString(key);
  }

  // Amper için getter ve setter
  Future<void> saveSelectedAmper(int amper) async {
    await _preferences?.setInt('selectedAmper', amper);
  }

  int? getSelectedAmper() {
    return _preferences?.getInt('selectedAmper');
  }

  // Fase için getter ve setter
  Future<void> saveSelectedFase(String phase) async {
    await _preferences?.setString('phase', phase);
  }

  String? getSelectedFase() {
    return _preferences?.getString('phase');
  }

  // Mod için getter ve setter
  Future<void> saveSelectedMode(String mode) async {
    await _preferences?.setString('mode', mode);
  }

  String? getSelectedMode() {
    return _preferences?.getString('mode');
  }

  // Değerleri temizleme
  Future<void> clearAllValues() async {
    await _preferences?.clear();
  }
}
