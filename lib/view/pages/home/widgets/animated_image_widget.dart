import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';
import 'package:fluttet_hm10/constants/app_images.dart';

class AnimatedImageWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const AnimatedImageWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.01,
      left: screenWidth * 0.16,
      child: SizedBox(
        width: screenWidth * 0.7,
        height: screenHeight * 0.7,
        child: Consumer<HomeViewModel>(
          builder: (context, dataProvider, _) {
            String imagePath = dataProvider.parsedDataList.isNotEmpty
                ? (() {
                    if (dataProvider.parsedDataList[0] == 5) {
                      return AppImages.acPink;
                    } else if (dataProvider.parsedDataList[0] == 6) {
                      return AppImages.acBlue;
                    } else if (dataProvider.parsedDataList[0] == 9) {
                      return AppImages.acTurkuaz;
                    } else {
                      return AppImages.acGreen;
                    }
                  })()
                : AppImages.acGreen;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Image.asset(
                imagePath,
                key: ValueKey(imagePath),
                width: screenWidth * 0.7,
                height: screenHeight * 0.7,
              ),
            );
          },
        ),
      ),
    );
  }
} 