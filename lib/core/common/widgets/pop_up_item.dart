import 'package:flutter/material.dart';

import '../../res/colours.dart';

class PopUpItem extends StatelessWidget {
  const PopUpItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colours.primaryColour),
          ),
        )
      ],
    );
  }
}
