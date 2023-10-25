import 'package:clean_architecture_tdd_flutter_template/core/common/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_tdd_flutter_template/core/extensions/context_extensions.dart';
import 'package:clean_architecture_tdd_flutter_template/core/res/fonts.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/domain/entities/page_content.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * .4,
        ),
        SizedBox(height: context.height * .03),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.inter,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.height * .02),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.inter,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: context.height * .05),
              RoundedButton(
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
