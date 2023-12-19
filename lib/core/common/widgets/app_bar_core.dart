import 'package:flutter/material.dart';

import '../../res/colours.dart';

class AppBarCore extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCore({
    super.key,
    required this.title,
    this.icon,
    this.child,
    this.size = 20,
    this.isBackButton = false,
    this.centerTitle = false,
    this.onPressed,
  });

  final Icon? icon;
  final String title;
  final Widget? child;
  final double? size;
  final bool? isBackButton;
  final bool centerTitle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        child != null
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: child,
              )
            : const SizedBox.shrink(),
      ],
      centerTitle: centerTitle,
      backgroundColor: Colours.primaryColour,
      foregroundColor: Colours.secondaryColour,
      elevation: 0,
      leading: isBackButton == true
          ? IconButton(
              icon: Icon(
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Icons.arrow_back_ios_new
                    : Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
                onPressed?.call();
              },
              color: Colours.secondaryColour,
              iconSize: 30,
            )
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: TextStyle(
          color: Colours.secondaryColour,
          fontSize: size,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
