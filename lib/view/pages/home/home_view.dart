import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/utils/bluetooth_singleton.dart';
import 'package:fluttet_hm10/utils/screensize_singleton.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/amper_button_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/animated_image_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/background_image_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/charge_control_button.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/feedback_message_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/mode_info_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/phase_dialog_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/power_info_widget.dart';
import 'package:fluttet_hm10/view/pages/home/widgets/temperature_widget.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluttet_hm10/services/shared_preferences_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});


  @override
  State<HomeView> createState() => _Home2State();
}

class _Home2State extends State<HomeView> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  BluetoothDevice? selectedDevice = BluetoothManager().selectedDevice;
  bool isVisible = true;
  int _selectedAmper = 6;
  bool isBluetoothConnected = false;
  String _selectedPhase = "";
  String _selectedMode = "";

  @override
  void initState() {
    super.initState();
    _startBluetoothListener();
    // Bluetooth bağlantısı varsa veri almaya başla
    if (selectedDevice != null) {
      _startDataFetching();
    }
    // Sadece bir kez çağır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSharedData();
    });
  }

  void _startBluetoothListener() {
    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.off ||
          state == BluetoothConnectionState.disconnected ||
          state == BluetoothConnectionState.disconnecting) {
        // Bluetooth bağlantısı yoksa
        isBluetoothConnected = false;
      } else {
        // Bluetooth bağlantısı aktifse
        isBluetoothConnected = true;
      }
    });
  }


//mixin
  Future<void> _startDataFetching() async {
    if (selectedDevice != null) {
      await context.read<HomeViewModel>().startDataFetching(selectedDevice!);
    }
  }
    Future<void> disconnectFromDevice() async {
    if (selectedDevice != null) {
      await selectedDevice!.disconnect();
      setState(() {
        selectedDevice = null;
      });
    }
  }



 //region yapılan seçimleri shared'a kaydeder.

//enum
  Future<void> _loadSharedData() async {
    await SharedPreferencesService.loadAllSharedData(
      context: context,
      selectedDevice: selectedDevice,
      onAmperLoaded: (amper) {
        setState(() {
          _selectedAmper = amper;
        });
      },
      onPhaseAndModeLoaded: (phase, mode) {
        setState(() {
          _selectedPhase = phase;
          _selectedMode = mode;
        });

        // Sadece fase ve mod boşsa dialog'u göster
        if (phase.isEmpty && mode.isEmpty && mounted) {
          PhaseDialogWidget.showPhaseDialog(
            context,
            selectedDevice,
            (newPhase, newMode) {
              setState(() {
                _selectedPhase = newPhase;
                _selectedMode = newMode;
              });
            },
          );
        }
      },
    );
  }
//endregion

  @override
  Widget build(BuildContext context) {
    DeviceInfo().init(context);
    double screenWidth = DeviceInfo().screenWidth;
    double screenHeight = DeviceInfo().screenHeight;
    double fontSizeRatio = screenWidth * 0.05;
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImageWidget(),
          Positioned(
            left: screenWidth*0.87,
            top: screenHeight*0.07,
            child: GestureDetector(
              onTap: () {
                // Settings ikonuna tıklandığında dialog'u göster
                PhaseDialogWidget.showPhaseDialog(
                  context,
                  selectedDevice,
                  (phase, mode) {
                    setState(() {
                      _selectedPhase = phase;
                      _selectedMode = mode;
                    });
                  },
                );
              },
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: screenHeight * 0.05,
              ),
            ),
          ),

          AnimatedImageWidget(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),

          PowerInfoWidget(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            selectedAmper: _selectedAmper,
            selectedPhase: _selectedPhase,
          ),

          FeedbackMessageWidget(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),

          TemperatureWidget(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            fontSizeRatio: fontSizeRatio,
          ),

          ModeInfoWidget(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            fontSizeRatio: fontSizeRatio,
          ),

          Center(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.33),
              child: Text(
                "HomePage.setAmperText".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),

          AmperButtonsWidget(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            selectedDevice: selectedDevice ?? BluetoothDevice(remoteId: const DeviceIdentifier('00:00:00:00:00:00')), // Dummy device
            isBluetoothConnected: isBluetoothConnected,
            selectedAmper: _selectedAmper,
            onAmperSelected: (amper) {
              if (selectedDevice != null) {
                setState(() {
                  _selectedAmper = amper;
                });
                context.read<HomeViewModel>().handleAmperCondition(
                  selectedDevice!,
                  amper,
                  context,
                  isBluetoothConnected
                );
              }
            },
          ),

          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChargeControlButton(
                  text: 'HomePage.startButtonText'.tr(),
                  onPressed: selectedDevice == null ? null : () async {
                    final viewModel = context.read<HomeViewModel>();  //viewmodel'ı oku
                    await viewModel.handleStartCharging(context,selectedDevice,_selectedAmper);
                    if (selectedDevice == null) {
                      context.go('/connect');
                    }
                  },
                  backgroundColor: Colors.white,
                ),
                ChargeControlButton(
                  text: 'HomePage.stopButtonText'.tr(),
                  onPressed: selectedDevice == null ? null : () async {
                    final viewModel = context.read<HomeViewModel>();
                    await viewModel.handleStopCharging(
                      context, 
                      selectedDevice, 
                      _selectedMode,
                      () async {
                        await disconnectFromDevice();
                        context.go('/connect');
                      }
                    );
                  },
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
