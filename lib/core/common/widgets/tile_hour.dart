import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../../res/fonts.dart';

class TileHour extends StatelessWidget {
  const TileHour({super.key, required this.hour});

  final int hour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          hour < 10 ? '0$hour' : '$hour',
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
