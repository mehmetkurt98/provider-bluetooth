import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const String selectedLanguageKey = 'selected_language'; // key değerinin değişkene atanması
  static const String infoStateKey = 'info_state'; // bool değeri için key değeri

  static Future<void> saveSelectedLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(selectedLanguageKey, languageCode);
  }

  static Future<String?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectedLanguageKey);
  }

  static Future<void> saveInfoState(bool infoState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(infoStateKey, infoState);
  }

  static Future<bool?> getInfoState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(infoStateKey);
  }
}

class SharedClass {
  // Private static instance to store SharedPreferences
  static SharedPreferences? _prefs;
  static Future<SharedPreferences> get instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // Save the charge mode to shared preferences
  Future<void> kurtSaveChargeMode(String mode) async {
    SharedPreferences prefs = await SharedClass.instance;
    await prefs.setString('mode', mode);
  }

  // Load the charge mode from shared preferences
  Future<String> kurtLoadChargeMode() async {
    SharedPreferences prefs = await SharedClass.instance;
    // 'mode' null ise 'defaultMode' değerini döndürüyoruz
    return prefs.getString('mode') ?? 'defaultMode';
  }





  // Save the charge mode to shared preferences
  Future<void> kurtSaveFase(String phase) async {
    SharedPreferences prefs = await SharedClass.instance;
    await prefs.setString('phase', phase);
  }

  // Load the charge mode from shared preferences
  Future<String> kurtLoadFase() async {
    SharedPreferences prefs = await SharedClass.instance;
    // 'mode' null ise 'defaultMode' değerini döndürüyoruz
    return prefs.getString('phase') ?? 'defaultMode';
  }





  // Save the charge mode to shared preferences
  Future<void> kurtSaveAmper(int amper) async {
    SharedPreferences prefs = await SharedClass.instance;
    await prefs.setInt('selectedAmper', amper);
  }

  // Load the charge mode from shared preferences
  Future<int> kurtLoadAmper() async {
    SharedPreferences prefs = await SharedClass.instance;
    // 'mode' null ise 'defaultMode' değerini döndürüyoruz
    return prefs.getInt('selectedAmper') ?? 6;
  }

}

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  late SharedPreferences _preferences;

  // Private constructor
  SharedPreferencesService._();

  // Singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    // Wait until the preferences are loaded
    _instance!._preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  // Save the amper value to shared preferences
  Future<void> saveAmper(int amper) async {
    await _preferences.setInt('selectedAmper', amper);
  }

  // Load the amper value from shared preferences
  Future<int> loadAmper() async {
    return _preferences.getInt('selectedAmper') ?? 6; // Default value: 6
  }
}



/*

  Future<void> kurtSaveChargeMode(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mode', mode);
  }
  Future<void> kurtLoadChargeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getString('mode');
  }
 */