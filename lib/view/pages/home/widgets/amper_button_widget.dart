import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttet_hm10/utils/vb10_shared.dart';
import 'package:fluttet_hm10/view_model/home_view_model.dart';

class AmperButtonsWidget extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final BluetoothDevice selectedDevice;
  final bool isBluetoothConnected;
  final int selectedAmper;
  final Function(int) onAmperSelected;

  const AmperButtonsWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.selectedDevice,
    required this.isBluetoothConnected,
    required this.selectedAmper,
    required this.onAmperSelected,
  }) : super(key: key);

  @override
  State<AmperButtonsWidget> createState() => _AmperButtonsWidgetState();
}

class _AmperButtonsWidgetState extends State<AmperButtonsWidget> {
  Widget buildAmperButton(int amper, double fontSize) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return ChoiceChip(
            backgroundColor: Colors.white24,
            selectedColor: Colors.white10,
            elevation: 0,
            pressElevation: 0,
            shadowColor: Colors.transparent,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: Text(
              '$amper A',
              style: TextStyle(
                color: viewModel.isAmperChanging ? Colors.grey : Colors.black,
                fontSize: fontSize
              ),
            ),
            selected: widget.selectedAmper == amper,
            onSelected: viewModel.isAmperChanging ? null : (isSelected) async {
              if (widget.isBluetoothConnected) {
                widget.onAmperSelected(isSelected ? amper : widget.selectedAmper);
                SharedManager.instance.saveSelectedAmper(widget.selectedAmper);
                await viewModel.handleAmperCondition(
                  widget.selectedDevice,
                  amper,
                  context,
                  widget.isBluetoothConnected
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.screenHeight * 0.7,
      left: widget.screenWidth * 0.05,
      right: widget.screenWidth * 0.05,
      child: Container(
        width: double.infinity,
        height: widget.screenHeight * 0.09,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              spacing: widget.screenWidth * 0.002,
              runSpacing: widget.screenHeight * 0.01,
              alignment: WrapAlignment.center,
              children: [
                buildAmperButton(6, widget.screenWidth * 0.035),
                buildAmperButton(10, widget.screenWidth * 0.035),
                buildAmperButton(16, widget.screenWidth * 0.035),
                buildAmperButton(32, widget.screenWidth * 0.035),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 