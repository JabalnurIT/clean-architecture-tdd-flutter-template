import 'package:flutter/material.dart';
import '../../res/colours.dart';
import '../../res/fonts.dart';

class DialogConfirmation extends StatelessWidget {
  const DialogConfirmation({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    required this.title,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colours.secondaryColour,
      iconPadding: const EdgeInsets.all(10),
      icon: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Icon(
                  Icons.close_rounded,
                  color: Colours.primaryColour,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
      title: Container(
          width: 100,
          height: 160,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colours.secondaryColour,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            shape: BoxShape.rectangle,
          ),
          child: icon),
      content: Center(
        heightFactor: 3,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: foregroundColor ?? Colours.primaryColour,
            fontFamily: Fonts.inter,
          ),
        ),
      ),
    );
  }
}
