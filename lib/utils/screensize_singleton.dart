
import 'package:flutter/cupertino.dart';

class DeviceInfo {
  // Singleton instance
  static final DeviceInfo _singleton = DeviceInfo._internal();

  // Private constructor
  DeviceInfo._internal();

  // Factory constructor to return the singleton instance
  factory DeviceInfo() {
    return _singleton;
  }

  // Screen width and height variables
  double screenWidth = 0.0;
  double screenHeight = 0.0;

  // Function to initialize screen dimensions
  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

  }
}