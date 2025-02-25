import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';

class ModeInfoWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final double fontSizeRatio;

  const ModeInfoWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.fontSizeRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.08,
      left: screenWidth * 0.22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.info_circle, color: Colors.white),
          const SizedBox(width: 10),
          Consumer<HomeViewModel>(
            builder: (context, viewModel, _) {
              print("ModeInfoWidget yeniden build ediliyor");
              print("ParsedDataList: ${viewModel.parsedDataList}");
              
              final isChargeControl = viewModel.parsedDataList.isNotEmpty && 
                                    viewModel.parsedDataList[1] == 1;
              
              print("Mode durumu: ${isChargeControl ? 'Charge Control' : 'Plug and Play'}");
              
              return Text(
                isChargeControl ? "Charge Control Mode" : "Plug and Play Mode",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeRatio * 0.9,
                  fontWeight: FontWeight.w500,
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