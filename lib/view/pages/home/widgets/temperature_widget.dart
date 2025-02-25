import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';
import 'package:fluttet_hm10/constants/app_images.dart';

class TemperatureWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final double fontSizeRatio;

  const TemperatureWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.fontSizeRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.34,
      left: screenWidth * 0.40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: Image.asset(AppImages.heatIcon),
          ),
          Consumer<HomeViewModel>(
            builder: (context, dataProvider, _) {
              return Text(
                '${dataProvider.parsedDataList.isNotEmpty ? dataProvider.parsedDataList[3].toString() : 'noData'.tr()}${dataProvider.parsedDataList.isNotEmpty ? ' °C' : ''}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeRatio * 0.9,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              );
            },
          ),
        ],
      ),
    );
  }
} 