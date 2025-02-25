import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SharedPreferencesService {
  static Future<void> loadAllSharedData({
    required BuildContext context,
    required BluetoothDevice? selectedDevice,
    required Function(int) onAmperLoaded,
    required Function(String, String) onPhaseAndModeLoaded,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int selectedAmper = prefs.getInt('selectedAmper') ?? 6;
    String selectedPhase = prefs.getString('phase') ?? '';
    String selectedMode = prefs.getString('mode') ?? '';

    // Yüklenen değerleri callback ile ana sayfaya ilet
    onAmperLoaded(selectedAmper);
    onPhaseAndModeLoaded(selectedPhase, selectedMode);
  }
} 