import 'package:flutter/material.dart';
import '../../extensions/context_extensions.dart';
import '../../res/colours.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key, this.onPressed});

  // onPressed
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => context.pop(),
      child: IconButton(
        color: Colours.secondaryColour,
        iconSize: 30,
        icon: Icon(
          Theme.of(context).platform == TargetPlatform.iOS
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
        ),
        onPressed: () {
          try {
            onPressed?.call();
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
