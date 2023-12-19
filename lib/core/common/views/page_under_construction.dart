import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../res/media_res.dart';
import '../widgets/gradient_background.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.colorBackground,
        child: Center(
          child: Lottie.asset(
            MediaRes.construction,
          ),
        ),
      ),
    );
  }
}
