import 'package:flutter/material.dart';

class BluetoothAnimation extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isVisible;

  const BluetoothAnimation({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bluetooth İkonu
        Positioned(
          top: screenHeight * 0.41,
          left: screenWidth * 0.40,
          child: Visibility(
            visible: isVisible,
            child: Stack(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/ezgi/blee.png',
                  width: screenWidth * 0.20,
                  height: screenHeight * 0.20,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
        // İç Çember
        Positioned(
          top: screenHeight * 0.435,
          left: screenWidth * 0.345,
          child: Visibility(
            visible: isVisible,
            child: Stack(
              children: [
                Container(
                  width: screenWidth * 0.30,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Dış Çember
        Positioned(
          left: screenWidth * 0.296,
          top: screenHeight * 0.384,
          child: Visibility(
            visible: isVisible,
            child: Stack(
              children: [
                Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 