import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/ezgi/arkaplan.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
} 