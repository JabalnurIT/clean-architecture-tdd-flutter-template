import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../../res/fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    required this.text,
    this.fontFamily,
    this.fontWeight,
    this.horizontalPadding,
    this.verticalPadding,
    this.radius,
    this.icon,
    this.iconPositionFront = true,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final String text;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final Icon? icon;
  final bool iconPositionFront;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 50,
          vertical: verticalPadding ?? 17,
        ),
        backgroundColor: backgroundColor ?? Colours.primaryColour,
        foregroundColor: foregroundColor ?? Colors.white,
      ),
      onPressed: () async {
        onPressed();
      },
      child: icon == null
          ? Text(
              text,
              style: TextStyle(
                fontFamily: fontFamily ?? Fonts.inter,
                fontWeight: fontWeight ?? FontWeight.bold,
                color: foregroundColor ?? Colors.white,
              ),
            )
          : SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (iconPositionFront) ? icon! : const SizedBox(),
                  (iconPositionFront)
                      ? const SizedBox(width: 10)
                      : const SizedBox(),
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: fontFamily ?? Fonts.inter,
                      fontWeight: fontWeight ?? FontWeight.bold,
                      color: foregroundColor ?? Colors.white,
                    ),
                  ),
                  (!iconPositionFront)
                      ? const SizedBox(width: 10)
                      : const SizedBox(),
                  (!iconPositionFront) ? icon! : const SizedBox(),
                ],
              ),
            ),
    );
  }
}
