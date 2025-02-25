import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';

class FeedbackMessageWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const FeedbackMessageWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  String _getConnectionStatusMessage(List<dynamic> parsedDataList) {
    if (parsedDataList.isNotEmpty) {
      if (parsedDataList[0] == 5) {
        return 'HomeUIFeedbackMessages.chargeSocketConnected'.tr();
      } else if (parsedDataList[0] == 9) {
        return 'HomeUIFeedbackMessages.startCommandSent'.tr();
      } else if (parsedDataList[0] == 6) {
        return 'HomeUIFeedbackMessages.vehicleCharging'.tr();
      } else {
        return 'HomeUIFeedbackMessages.socketNotConnect'.tr();
      }
    }
    return 'HomeUIFeedbackMessages.none'.tr();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.325,
      left: screenWidth / 28,
      right: screenWidth / 80,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.33),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: screenHeight * 0.03,
                ),
                const SizedBox(width: 5),
                Consumer<HomeViewModel>(
                  builder: (context, dataProvider, _) {
                    return Text(
                      _getConnectionStatusMessage(dataProvider.parsedDataList),
                      style: TextStyle(
                        fontSize: screenWidth * 0.0325,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 