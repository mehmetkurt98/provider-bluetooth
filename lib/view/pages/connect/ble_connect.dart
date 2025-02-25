import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttet_hm10/utils/screensize_singleton.dart';
import 'package:fluttet_hm10/utils/toast.dart';
import 'package:fluttet_hm10/view/pages/connect/widgets/bluetooth_animation.dart';
import 'package:fluttet_hm10/view/pages/connect/widgets/bluetooth_device_dialog.dart';
import 'package:fluttet_hm10/view_model/bluetooth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluttet_hm10/utils/bluetooth_permission_helper.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';

class BleConnnectPage extends StatefulWidget {
  const BleConnnectPage({Key? key}) : super(key: key);

  @override
  State<BleConnnectPage> createState() => _BleConnnectPageState();
}

class _BleConnnectPageState extends State<BleConnnectPage> {
  bool _permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    // Sayfa açılır açılmaz kontrolleri yap
    Future.delayed(Duration.zero, () async {
      // Bluetooth izinlerini kontrol et ve iste
      final hasPermissions = await BluetoothPermissionHelper.blePermission(context);
      setState(() {
        _permissionsGranted = hasPermissions;
      });

      // İzinler verildiyse Bluetooth'u kontrol et ve aç
      if (_permissionsGranted && mounted) {
        if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.off) {
          String bluetoothStatus = await BluetoothEnable.enableBluetooth;
          if (bluetoothStatus != "true") {
            if (mounted) BaseToastMessage.bleErrorMessage(context);
          }
        }
      }
    });
  }

  void _handleButtonClick(BuildContext context, BluetoothViewModel viewModel) async {
    // Konum servisi açık mı kontrol et
    bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      if (mounted) BaseToastMessage.gpsDisabledMessage(context);
      return;
    }

    // Konum açıksa taramayı başlat
    viewModel.setLoading(true);
    await viewModel.startScan(context);
    
    if (viewModel.scanResults.isNotEmpty && viewModel.scanResults.any((result) => result.device.name.isNotEmpty)) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          builder: (context) => BluetoothDeviceDialog(
            devices: viewModel.scanResults,
            onConnect: (device) async {
              final success = await viewModel.connectToDevice(device);
              if (success) {
                BaseToastMessage.ToastSuccessMessage();
                if (context.mounted) {
                  context.go('/home');
                }
              } else {
                BaseToastMessage.ToastFailedMessage();
              }
            },
          ),
        );
      }
    }
    viewModel.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfo().init(context);
    double screenWidth = DeviceInfo().screenWidth;
    double screenHeight = DeviceInfo().screenHeight;
    double fontSizeRatio = screenWidth * 0.05;

    return ChangeNotifierProvider(
      create: (_) => BluetoothViewModel(),
      child: Consumer<BluetoothViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/ezgi/arkaplan.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.08),
                    child: Text(
                      'BluetoothPage.title'.tr(),
                      style: TextStyle(
                        fontSize: fontSizeRatio * 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                BluetoothAnimation(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  isVisible: viewModel.isVisible,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.88, left: screenWidth * 0.20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white54,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(screenWidth * 0.6, screenHeight * 0.06),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    ),
                    onPressed: viewModel.isLoading ? null : () => _handleButtonClick(context, viewModel),
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            _permissionsGranted ? 'BluetoothPage.scanButtonText'.tr() : 'BluetoothPage.permissionButtonText'.tr(),
                            style: TextStyle(fontSize: fontSizeRatio),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}