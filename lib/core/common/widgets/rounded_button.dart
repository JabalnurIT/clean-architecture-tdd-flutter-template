import 'package:clean_architecture_tdd_flutter_template/core/res/colours.dart';
import 'package:clean_architecture_tdd_flutter_template/core/res/fonts.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.backgroundColor,
      this.foregroundColor,
      required this.onPressed,
      required this.text,
      this.fontFamily,
      this.fontWeight,
      this.horizontalPadding,
      this.verticalPadding});

  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final String text;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily ?? Fonts.inter,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
      ),
    );
  }
}
