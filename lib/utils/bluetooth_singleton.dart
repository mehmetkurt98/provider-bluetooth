import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothManager {
  BluetoothDevice? _selectedDevice;
  static final BluetoothManager _instance = BluetoothManager._internal();

  factory BluetoothManager() {
    return _instance;
  }

  BluetoothManager._internal() {
    _selectedDevice = null;
  }

  BluetoothDevice? get selectedDevice => _selectedDevice;

  set selectedDevice(BluetoothDevice? device) {
    _selectedDevice = device;
  }
}


