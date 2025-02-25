import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/utils/toast.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttet_hm10/utils/logger_utils.dart';

class HomeViewModel with ChangeNotifier {
  List<double> _parsedDataList = [0, 0, 0, 0, 0];
  List<double> get parsedDataList => _parsedDataList;
  BluetoothCharacteristic? _writeCharacteristic;
  BluetoothCharacteristic? _notifyCharacteristic;
  final bool _isProcessing = false;
  bool _isAmperChanging = false;

  // Getters
  BluetoothCharacteristic? get writeCharacteristic => _writeCharacteristic;
  BluetoothCharacteristic? get notifyCharacteristic => _notifyCharacteristic;
  bool get isProcessing => _isProcessing;
  bool get isAmperChanging => _isAmperChanging;

  // Mode durumunu parsedDataList'ten al
  bool get isChargeControlMode => 
      _parsedDataList.isNotEmpty && _parsedDataList[1] == 1;


  // Veri gönderme işlemi

    Future<void> goData(BluetoothDevice device, String value) async {
      // 1. Cihaz bağlantı kontrolü
      List<BluetoothService> services = await device.discoverServices();

      for (BluetoothService service in services) {
        // 2. UUID kontrolü (büyük/küçük harf duyarlılığı)
        if (service.uuid.toString().toLowerCase() == "0000ffe0-0000-1000-8000-00805f9b34fb") {
          for (BluetoothCharacteristic c in service.characteristics) {
            // 3. Karakteristik özellik kontrolü
            if (c.properties.write || c.properties.writeWithoutResponse) {
              Uint8List data = Uint8List.fromList(utf8.encode(value));
              
              // Yazma işlemi için kritik parametre
              await c.write(
                data,
                withoutResponse: c.properties.writeWithoutResponse
              );

              // Başarılı log
              print("✅ Veri gönderildi: ${String.fromCharCodes(data)}");
              return;
            }
          }
        }
      }
  }




  // Bu fonksiyon ble'den veriyi alır ve veriyi istenen formata çevirir.
  Future<void> startDataFetching(BluetoothDevice selectedDevice) async {
    try {
      print("Veri alma başlatılıyor...");
      List<BluetoothService> services = await selectedDevice.discoverServices();
      print("Bulunan servis sayısı: ${services.length}");
      
      for (BluetoothService service in services) {
        print("Servis UUID: ${service.uuid}");
        if (service.uuid.toString().toLowerCase().contains("ffe0")) {
          print("HM-10 servisi bulundu");
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            print("Karakteristik UUID: ${characteristic.uuid}, özellikleri: notify=${characteristic.properties.notify}, write=${characteristic.properties.write}");
            
            // Notify özelliği olan karakteristiği bul
            if (characteristic.properties.notify || characteristic.properties.indicate) {
              _notifyCharacteristic = characteristic;
              await characteristic.setNotifyValue(true);
              print("Notify karakteristiği ayarlandı");
              
              characteristic.value.listen((value) {
                print("Cihazdan gelen ham veri: $value");
                String receivedData = String.fromCharCodes(value);
                print("Çözümlenen veri: $receivedData");
                List<String> parsedData = receivedData.split('#');
                List<double> doubleData = [];
                for (String data in parsedData) {
                  List<String> numbers = data.split(RegExp(r'[^0-9.-]'));
                  for (String number in numbers) {
                    if (number.isNotEmpty) {
                      double? parsedNumber = double.tryParse(number);
                      if (parsedNumber != null) {
                        doubleData.add(parsedNumber);
                      }
                    }
                  }
                }
                if (doubleData.isNotEmpty) {
                  print("İşlenmiş veri: $doubleData");
                  updateDataList(doubleData);
                }
              });
            }
            
            // Write özelliği olan karakteristiği bul
            if (characteristic.properties.write || characteristic.properties.writeWithoutResponse) {
              _writeCharacteristic = characteristic;
              print("Write karakteristiği ayarlandı: ${characteristic.uuid}");
            }
          }
        }
      }
      
      // Karakteristiklerin durumunu kontrol et
      if (_notifyCharacteristic == null) {
        print("Notify karakteristiği bulunamadı!");
      }
      if (_writeCharacteristic == null) {
        print("Write karakteristiği bulunamadı!");
      }
      
    } catch (e) {
      print('Veri alma hatası: $e');
      rethrow;
    }
  }

  // Veriyi günceller
  void updateDataList(List<double> newData) {
    if (listEquals(_parsedDataList, newData)) return;
    _parsedDataList = newData;
    notifyListeners();
  }

  // Notify durumunu kontrol et
  bool get isNotifying => _notifyCharacteristic?.properties.notify ?? false;

  // Notify'ı durdur
  Future<void> stopNotifying() async {
    if (_notifyCharacteristic != null) {
      await _notifyCharacteristic!.setNotifyValue(false);
    }
  }

  @override
  void dispose() {
    stopNotifying();
    super.dispose();
  }

  Future<void> handleStartCharging(BuildContext context, BluetoothDevice? selectedDevice, int selectedAmper) async {
    if (_isProcessing) return;
    
    if(selectedDevice != null) {
      try {
        String amperCommand = selectedAmper == 32 ? "2" : 
                            selectedAmper == 16 ? "3" : 
                            selectedAmper == 10 ? "4" : "5";
        
        // Amper komutunu gönder
        await goData(selectedDevice, amperCommand);
        
        // Başarılı mesajını göster
        if (context.mounted) {
          BaseToastMessage.goDataSuccesMessage(context);
        }

        // 4 saniye bekle
        await Future.delayed(const Duration(seconds: 4));
        
        // Start komutunu gönder
        if (context.mounted) {
          await goData(selectedDevice, "1");
        }
      } catch (e) {
        if (context.mounted) {
          BaseToastMessage.goDataFailedMessage(context);
        }
        print("Şarj başlatma hatası: $e");
      }
    } else {
      BaseToastMessage.bleConnectingDisconnectMessage(context);
    }
  }

  Future<void> handleStopCharging(BuildContext context, BluetoothDevice? selectedDevice, String selectedMode, Function disconnectCallback) async {
    if (_isProcessing) return;
    
    if(!await isDeviceConnected()) {
      BaseToastMessage.goDataFailedMessage(context);
      await Future.delayed(const Duration(seconds: 1));
      await disconnectCallback();
    }
    else if(selectedMode == "Charge control") {
      await goData(selectedDevice!, "0");
      if (context.mounted) {
        BaseToastMessage.goDataStopMessage(context);
      }
    } else if(selectedMode != "Charge control") {
      BaseToastMessage.plugAndChargeErrorMessage(context);
    }
  }

  Future<bool> isDeviceConnected() async {
    try {
      if (_writeCharacteristic == null) {
        LoggerUtils.warning("Write karakteristiği bulunamadı");
        return false;
      }
      
      final state = await FlutterBluePlus.adapterState.first;
      if (state != BluetoothAdapterState.on) {
        LoggerUtils.warning("Bluetooth adaptörü kapalı");
        return false;
      }

      // Cihaz bağlantı durumunu kontrol et
      final deviceState = await _writeCharacteristic!.device.state.first;
      if (deviceState != BluetoothConnectionState.connected) {
        LoggerUtils.warning("Cihaz bağlı değil");
        return false;
      }

      return true;
    } catch (e) {
      LoggerUtils.error("Bağlantı durumu kontrolünde hata", e);
      return false;
    }
  }

  Future<void> handleAmperCondition(BluetoothDevice device, int amper, BuildContext context, bool isBluetoothConnected) async {
    // Bluetooth bağlantısını kontrol et
    if (!isBluetoothConnected) {
      BaseToastMessage.bleConnectingDisconnectMessage(context);
      if (context.mounted) {
        context.go('/connect');
      }
      return;
    }

    // Amper değişim durumunu kontrol et
    if (_isAmperChanging) return;

    _isAmperChanging = true;
    notifyListeners();

    try {
      final amperCommands = {
        32: "2",
        16: "3",
        10: "4",
        6: "5"
      };
      
      if (amperCommands.containsKey(amper)) {
        await goData(device, amperCommands[amper]!);
        if (context.mounted) {
          BaseToastMessage.amperChangeMessage(context);
        }
      }

      // 2 saniye bekle
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      print("Amper değiştirme hatası: $e");
    } finally {
      _isAmperChanging = false;
      notifyListeners();
    }
  }
}
