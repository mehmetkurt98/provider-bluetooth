import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseToastMessage{

  static ToastConnectMessage(String device){
    Fluttertoast.showToast(
        msg: "$device ${"BluetoothUIFeedbackMessages.connectingMessage".tr()}",
        toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
        gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
        backgroundColor: Colors.green, // Toast arka plan rengi
        textColor: Colors.white,
        fontSize: 16// Toast metin rengi
    );
  }

  static ToastFailedMessage(){
    Fluttertoast.showToast(
      msg: "BluetoothUIFeedbackMessages.connectFailureMessage".tr(),
      toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
      gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
      backgroundColor: Colors.red, // Toast arka plan rengi
      textColor: Colors.white, // Toast metin rengi
        fontSize: 18// Toast metin rengi

    );
  }
  static ToastFailedDeviceMessage(){
    Fluttertoast.showToast(
        msg: "Cihaz Bulunamadı",
        toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
        gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
        backgroundColor: Colors.red, // Toast arka plan rengi
        textColor: Colors.white, // Toast metin rengi
        fontSize: 18// Toast metin rengi

    );
  }
  static ToastFailedMessage2(){
    Fluttertoast.showToast(
        msg: "Hatalı Şifre!",
        toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
        gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
        backgroundColor: Colors.red, // Toast arka plan rengi
        textColor: Colors.white, // Toast metin rengi
        fontSize: 18// Toast metin rengi

    );
  }

  static ToastSuccessMessage(){
    Fluttertoast.showToast(
      msg: "BluetoothUIFeedbackMessages.connectSuccessMessage".tr(),
      toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
      gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
      backgroundColor: Colors.green, // Toast arka plan rengi
      textColor: Colors.white, // Toast metin rengi
        fontSize: 18// Toast metin rengi

    );
  }
  static ToastSuccessDataMessage(){
    Fluttertoast.showToast(
        msg: "Komut Gönderildi",
        toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
        gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
        backgroundColor: Colors.blue, // Toast arka plan rengi
        textColor: Colors.white, // Toast metin rengi
        fontSize: 18// Toast metin rengi

    );
  }
  static ToastSuccessFailedMessage(){
    Fluttertoast.showToast(
        msg: "Komut Gönderilemedi.Bluetooth bağlantınızı kontol edin.",
        toastLength: Toast.LENGTH_SHORT, // Toast mesajının süresi
        gravity: ToastGravity.BOTTOM, // Toast mesajının konumu (altta)
        backgroundColor: Colors.blue, // Toast arka plan rengi
        textColor: Colors.white, // Toast metin rengi
        fontSize: 5// Toast metin rengi

    );
  }

  static showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Komut Gönderilemedi. Bluetooth bağlantınızı kontrol edin."),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2), // SnackBar'ın süresi
        behavior: SnackBarBehavior.floating, // SnackBar'ın davranışı (daha fazla metin için yüzen bir SnackBar)
        action: SnackBarAction(
          label: 'Kapat',
          onPressed: () {
            // SnackBar'ı kapatmak için bir işlem ekleyebilirsiniz
          },
        ),
      ),
    );
  }
  static goDataFailedMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white), // Hata işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "commandFailedMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static goDataSuccesMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6, // Snackbar'a hafif bir yükseltme ekler
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Snackbar'ın köşelerini yuvarlar
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green, // Arka plan rengi
          borderRadius: BorderRadius.circular(16), // Kareyi yuvarlar
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white), // Başarılı işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "startMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static plugAndChargeErrorMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6, // Snackbar'a hafif bir yükseltme ekler
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Snackbar'ın köşelerini yuvarlar
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red, // Arka plan rengi
          borderRadius: BorderRadius.circular(16), // Kareyi yuvarlar
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white), // Başarılı işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "BluetoothUIFeedbackMessages.chargeModeStopErrorMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static goDataStopMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white), // Hata işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "stopMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static goDataResetMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.refresh, color: Colors.white), // Yenileme işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "resetMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static configureMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white), // Onay işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "successMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static statusErrorMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white), // Onay işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "BluetoothUIFeedbackMessages.localPermissionMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static bleErrorMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white), // Onay işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "BluetoothUIFeedbackMessages.blePermissionMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static amperConditionMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "HomeUIFeedbackMessages.amperConditionMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static bleConnectingMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.bluetooth, color: Colors.white), // Yenileme işareti
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "BluetoothUIFeedbackMessages.scanStarted".tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static bleConnectingDisconnectMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.white), // Yenileme işareti
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "BluetoothUIFeedbackMessages.bleDisconnectMessage".tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static bleDeviceNotFoundMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "BluetoothUIFeedbackMessages.deviceNotFound".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static bleAvailableDeviceListPieceMessage(BuildContext context, int deviceCount) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tr('bleDevicePieceMessage', args: [deviceCount.toString()]),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static amperChangeMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.electric_bolt, color: Colors.white), // Hata işareti
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Amper başarılı şekilde değiştirildi.".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void bleDisabledMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.bluetooth_disabled, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Lütfen Bluetooth özelliğini açın",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void gpsDisabledMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_disabled, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "BluetoothUIFeedbackMessages.localPermissionMessage".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void locationPermissionMessage(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.location_off, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Lütfen konum iznini verin",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
