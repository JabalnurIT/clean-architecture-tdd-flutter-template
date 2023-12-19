import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../../res/fonts.dart';

class TileMinute extends StatelessWidget {
  const TileMinute({super.key, required this.minute});

  final int minute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          minute < 10 ? '0$minute' : '$minute',
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colours.primaryColour,
            fontFamily: Fonts.inter,
          ),
        ),
      ),
    );
  }
}
