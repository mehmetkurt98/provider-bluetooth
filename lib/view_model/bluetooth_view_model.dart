import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/services/bluetooth_scan_service.dart';
import 'package:fluttet_hm10/utils/bluetooth_singleton.dart';

class BluetoothViewModel extends ChangeNotifier {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  bool _isLoading = false;
  bool _isVisible = true;
  BluetoothDevice? _selectedDevice;

  // Getters
  List<ScanResult> get scanResults => _scanResults;
  bool get isScanning => _isScanning;
  bool get isLoading => _isLoading;
  bool get isVisible => _isVisible;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  // Scan işlemi
  Future<void> startScan(BuildContext context) async {
    if (_isScanning) {
      await FlutterBluePlus.stopScan();
      _isScanning = false;
      notifyListeners();
      return;
    }

    _scanResults.clear();
    _isScanning = true;
    _isVisible = false;
    notifyListeners();

    final results = await BluetoothScanService.startScan(context);
    
    _scanResults = results;
    _isScanning = false;
    notifyListeners();
  }

  // Cihaza bağlanma
  Future<bool> connectToDevice(BluetoothDevice device) async {
    final success = await BluetoothScanService.connectToDevice(device);
    if (success) {
      _selectedDevice = device;
      BluetoothManager().selectedDevice = device;
      notifyListeners();
    }
    return success;
  }

  // Cihazdan ayrılma
  Future<void> disconnectFromDevice() async {
    if (_selectedDevice != null) {
      await BluetoothScanService.disconnectFromDevice(_selectedDevice!);
      _selectedDevice = null;
      notifyListeners();
    }
  }

  // Loading durumu
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // İzin kontrolü
  Future<bool> checkPermissions() async {
    return await BluetoothScanService.checkLocationPermission();
  }

  // Bluetooth izinlerini kontrol et
  Future<void> checkBluetoothPermissions() async {
    if (await FlutterBluePlus.isSupported == false) {
      return;
    }

    if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.off) {
      // Bluetooth kapalıysa açılmasını iste
      await FlutterBluePlus.turnOn();
    }
  }
} 