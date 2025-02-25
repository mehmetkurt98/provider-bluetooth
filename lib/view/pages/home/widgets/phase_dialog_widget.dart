import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/utils/toast.dart';
import 'package:fluttet_hm10/utils/vb10_shared.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class PhaseDialogWidget {
  static Future<void> showPhaseDialog(
    BuildContext context,
    BluetoothDevice? selectedDevice,
    Function(String, String) onPhaseAndModeSelected,
  ) async {
    String? savedPhase = SharedManager.instance.getStringValue('phase');
    String? savedMode = SharedManager.instance.getStringValue('mode');
    
    String selectedPhase = savedPhase ?? "";
    String selectedMode = savedMode ?? "";

    await showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black54,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: Colors.grey.shade400,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.info_circle),
                const SizedBox(width: 10),
                Text(
                  'HomePage.HomeShowDialog.faseTitle'.tr(),
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                ),
              ],
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                String modeDescription = '';
                if (selectedMode == "Plug and play") {
                  modeDescription = "HomePage.HomeShowDialog.plugModeDescription".tr();
                } else if (selectedMode == "Charge control") {
                  modeDescription = "HomePage.HomeShowDialog.controlModeDescription".tr();
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedPhase == "Tek Faz" ? Colors.blue : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedPhase = "Tek Faz";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'HomePage.HomeShowDialog.monoFaseButtonText'.tr(),
                                style: TextStyle(color: selectedPhase == "Tek Faz" ? Colors.white : Colors.black, fontSize: 15),
                              ),
                              if (selectedPhase == "Tek Faz")
                                const Icon(Icons.check, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedPhase == "Üç Faz" ? Colors.blue : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedPhase = "Üç Faz";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'HomePage.HomeShowDialog.thirdFaseButtonText'.tr(),
                                style: TextStyle(color: selectedPhase == "Üç Faz" ? Colors.white : Colors.black, fontSize: 15),
                              ),
                              if (selectedPhase == "Üç Faz")
                                const Icon(Icons.check, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.info_circle),
                        const SizedBox(width: 10),
                        Text(
                          'HomePage.HomeShowDialog.modeTitle'.tr(),
                          style: const TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedMode == "Plug and play" ? Colors.blue : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedMode = "Plug and play";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Plug and play'.tr(),
                                style: TextStyle(color: selectedMode == "Plug and play" ? Colors.white : Colors.black, fontSize: 13),
                              ),
                              if (selectedMode == "Plug and play")
                                const Icon(Icons.check, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedMode == "Charge control" ? Colors.blue : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedMode = "Charge control";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Charge control'.tr(),
                                style: TextStyle(color: selectedMode == "Charge control" ? Colors.white : Colors.black, fontSize: 13),
                              ),
                              if (selectedMode == "Charge control")
                                const Icon(Icons.check, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (selectedMode.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          modeDescription,
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (selectedMode.isNotEmpty && selectedPhase.isNotEmpty) {
                          await SharedManager.instance.saveSelectedFase(selectedPhase);
                          await SharedManager.instance.saveSelectedMode(selectedMode);
                          
                          final viewModel = context.read<HomeViewModel>();
                          
                          if (selectedMode == "Plug and play") {
                            await viewModel.goData(selectedDevice!, "6");
                          } else if (selectedMode == "Charge control") {
                            await viewModel.goData(selectedDevice!, "7");
                          }
                          
                          onPhaseAndModeSelected(selectedPhase, selectedMode);
                          Navigator.of(context).pop();
                          BaseToastMessage.configureMessage(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Lütfen mod ve faz seçimi yapınız'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "HomePage.HomeShowDialog.acceptButtonText".tr(),
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
} 