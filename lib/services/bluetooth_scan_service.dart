import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/utils/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttet_hm10/utils/logger_utils.dart';

class BluetoothScanService {
  static bool _isScanning = false;

  // Tüm izinleri ve özellikleri kontrol eden fonksiyon
  static Future<bool> checkAllPermissionsAndServices(BuildContext context) async {
    try {
      // Bluetooth desteğini kontrol et
      if (await FlutterBluePlus.isSupported == false) {
        LoggerUtils.error("Bluetooth desteklenmiyor");
        return false;
      }

      // Bluetooth açık mı kontrol et
      if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.off) {
        BaseToastMessage.bleDisabledMessage(context);
        return false;
      }

      // Konum servisi açık mı kontrol et
      bool locationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!locationEnabled) {
        BaseToastMessage.gpsDisabledMessage(context);
        return false;
      }

      // Konum izni kontrol et
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        BaseToastMessage.locationPermissionMessage(context);
        return false;
      }

      return true;
    } catch (e) {
      LoggerUtils.error("İzin kontrolü sırasında hata", e);
      return false;
    }
  }

  static Future<List<ScanResult>> startScan(BuildContext context) async {
    if (_isScanning) {
      return [];
    }

    // Önce tüm izinleri ve özellikleri kontrol et
    bool hasPermissions = await checkAllPermissionsAndServices(context);
    if (!hasPermissions) {
      return [];
    }

    List<ScanResult> scanResultList = [];
    _isScanning = true;

    try {
      // Mevcut taramayı durdur
      if (await FlutterBluePlus.isScanning.first) {
        await FlutterBluePlus.stopScan();
      }

      // Tarama başladı mesajı
      BaseToastMessage.bleConnectingMessage(context);

      // Scan sonuçlarını dinle
      var subscription = FlutterBluePlus.scanResults.listen((results) {
        // TT veya CW ile başlayan cihazları filtrele
        scanResultList = results.where((result) {
          final deviceName = result.device.name.toUpperCase();
          return deviceName.startsWith('TT') || deviceName.startsWith('CW');
        }).toList();
        LoggerUtils.info("Filtrelenmiş tarama sonuçları: ${scanResultList.length} cihaz");
      }, onError: (error) {
        LoggerUtils.error("Tarama hatası", error);
      });

      // Taramayı başlat
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 3),
        androidUsesFineLocation: true,
      );

      // Tarama tamamlandığında subscription'ı iptal et
      await Future.delayed(const Duration(seconds: 3));
      await subscription.cancel();
      _isScanning = false;

      // Eğer hiç cihaz bulunamadıysa hata mesajı göster
      if (scanResultList.isEmpty) {
        BaseToastMessage.bleDeviceNotFoundMessage(context);
      }

      return scanResultList;

    } catch (e) {
      LoggerUtils.error("Tarama sırasında bir hata oluştu", e);
      _isScanning = false;
      return [];
    }
  }

  static Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  static Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      return true;
    } catch (e) {
      print("Cihaza bağlanırken hata oluştu: $e");
      return false;
    }
  }

  static Future<void> disconnectFromDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
    } catch (e) {
      print("Cihazdan ayrılırken hata oluştu: $e");
    }
  }
} 