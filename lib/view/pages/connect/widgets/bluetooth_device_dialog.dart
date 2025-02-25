import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/utils/toast.dart';

class BluetoothDeviceDialog extends StatelessWidget {
  final List<ScanResult> devices;
  final Function(BluetoothDevice) onConnect;

  const BluetoothDeviceDialog({
    Key? key,
    required this.devices,
    required this.onConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: screenWidth * 0.5,
            height: screenHeight * 0.55,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0x008a8a8a),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BluetoothPage.bluetoothDialog.title'.tr(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'BluetoothPage.bluetoothDialog.altTitle'.tr(),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.bluetooth, color: Colors.grey, size: 35),
                    const SizedBox(width: 5),
                    Text(
                      "BluetoothPage.bluetoothDialog.searcingResult".tr(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDeviceList(context),
                const SizedBox(height: 20),
                _buildCloseButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceList(BuildContext context) {
    return devices.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: devices
                  .where((d) =>
                      d.device.platformName.isNotEmpty &&
                      d.device.platformName.startsWith("TT"))
                  .length,
              itemBuilder: (context, index) {
                var filteredDevices = devices
                    .where((d) =>
                        d.device.platformName.isNotEmpty &&
                        d.device.platformName.startsWith("TT"))
                    .toList();
                BluetoothDevice device = filteredDevices[index].device;

                return _buildDeviceListTile(context, device);
              },
            ),
          )
        : const Text('Hiçbir cihaz bulunamadı.');
  }

  Widget _buildDeviceListTile(BuildContext context, BluetoothDevice device) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10),
      leading: Image.asset("assets/ezgi/icon4x.png"),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.platformName.isNotEmpty
                    ? device.platformName
                    : 'Bilinmeyen Cihaz',
                style: const TextStyle(fontSize: 14),
              ),
              const Text(
                '22 kW AC Charger',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      onTap: () => _showPasswordDialog(context, device),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            'BluetoothPage.bluetoothDialog.button'.tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _showPasswordDialog(BuildContext context, BluetoothDevice device) {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bağlanmak İçin Şifrenizi Girin",
              style: TextStyle(fontSize: 15)),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: "Şifre"),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDialogButton(
                  "İptal",
                  () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 25),
                _buildDialogButton(
                  "Bağlan",
                  () => _handleConnect(context, device, textController.text),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: const BorderSide(color: Colors.black),
        fixedSize: const Size(100, 60),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleConnect(BuildContext context, BluetoothDevice device, String password) {
    Navigator.of(context).pop();
    if (password == device.platformName) {
      BaseToastMessage.ToastConnectMessage("$password Bağlanılıyor");
      onConnect(device);
    } else {
      BaseToastMessage.ToastFailedMessage2();
    }
  }
} 