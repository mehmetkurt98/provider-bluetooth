import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttet_hm10/utils/toast.dart';

class BluetoothPermissionHelper {
  static Future<bool> blePermission(BuildContext context) async {
    try {
      // Platforma göre izin listesi belirleme
      List<Permission> permissionsToRequest = [];
      
      if (Platform.isAndroid) {
        if (!await Permission.bluetooth.isGranted) {
          permissionsToRequest.add(Permission.bluetooth);
        }
        if (!await Permission.bluetoothScan.isGranted) {
          permissionsToRequest.add(Permission.bluetoothScan);
        }
        if (!await Permission.bluetoothConnect.isGranted) {
          permissionsToRequest.add(Permission.bluetoothConnect);
        }
        if (!await Permission.location.isGranted) {
          permissionsToRequest.add(Permission.location);
        }
      } else if (Platform.isIOS) {
        if (!await Permission.bluetooth.isGranted) {
          permissionsToRequest.add(Permission.bluetooth);
        }
        if (!await Permission.location.isGranted) {
          permissionsToRequest.add(Permission.location);
        }
      }

      // İzinler zaten verilmişse true döndür
      if (permissionsToRequest.isEmpty) {
        print("Gerekli tüm izinler zaten verilmiş.");
        return true;
      }

      // İzinleri iste
      Map<Permission, PermissionStatus> statuses = await permissionsToRequest.request();

      // Tüm izinlerin durumunu kontrol et
      bool allGranted = true;
      statuses.forEach((permission, status) {
        print("${permission.toString()} durumu: $status");
        if (!status.isGranted) {
          allGranted = false;
        }
      });

      if (!allGranted) {
        if (context.mounted) {
          BaseToastMessage.bleErrorMessage(context);
        }
      }

      return allGranted;
    } catch (e) {
      print("İzin isteme sırasında hata: $e");
      return false;
    }
  }
} 