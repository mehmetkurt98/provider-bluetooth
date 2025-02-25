import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';
import 'package:fluttet_hm10/constants/app_images.dart';

class PowerInfoWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final int selectedAmper;
  final String selectedPhase;

  const PowerInfoWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.selectedAmper,
    required this.selectedPhase,
  }) : super(key: key);

  String _getKwValue(int amper, String phase) {
    if (amper == 32 && phase == "Üç Faz") {
      return '22 kW';
    } else if (amper == 16 && phase == "Üç Faz") {
      return '11 kW';
    } else if (amper == 10 && phase == "Üç Faz") {
      return '7 kW';
    } else if (amper == 6 && phase == "Üç Faz") {
      return '3 kW';
    } else if (amper == 32 && phase == "Tek Faz") {
      return '7.4 kW';
    } else if (amper == 16 && phase == "Tek Faz") {
      return '3.7 kW';
    } else if (amper == 10 && phase == "Tek Faz") {
      return '2.3 kW';
    } else if (amper == 6 && phase == "Tek Faz") {
      return '1.3 kW';
    } else {
      return 'noData'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.30,
      left: screenWidth * 0.40,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(AppImages.powerIcon),
          ),
          const SizedBox(
            height: 5,
          ),
          Consumer<HomeViewModel>(
            builder: (context, dataProvider, _) {
              return Text(
                dataProvider.parsedDataList.isNotEmpty
                    ? _getKwValue(selectedAmper, selectedPhase)
                    : 'noData'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.045,
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