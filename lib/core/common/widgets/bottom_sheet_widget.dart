import 'package:flutter/material.dart';
import '../../res/colours.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.child,
    this.buttons,
    this.buttonsBottomPosition,
    this.height,
  });

  final Widget child;
  final List<Widget>? buttons;
  final double? buttonsBottomPosition;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colours.secondaryColour,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64,
                height: 8,
                decoration: BoxDecoration(
                  color: Colours.primaryColour,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: buttonsBottomPosition ?? 62,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  child,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buttons ?? [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
