import 'package:flutter/material.dart';

import 'onboarding_image_frame.dart';
import 'onboarding_bubbles.dart';

class OnboardingPageItem extends StatelessWidget
{
  final String title;
  final String image;

  const OnboardingPageItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView
    (
      child: Column
      (
        children:
        [
          SizedBox(height: 40),

          SizedBox
          (
            height: 300,
            child: Stack
            (
              clipBehavior: Clip.none,
              children:
              [
                const OnboardingBubbles(),
                Align
                (
                  alignment: Alignment.bottomCenter,
                  child: OnboardingImageFrame
                  (
                    image: image,
                    width: 250,
                    height: 300
                  )
                )
              ]
            )
          ),

          const SizedBox(height: 50),

          Padding
          (
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text
            (
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: colors.primary,height: 1.4)
            )
          ),

          const SizedBox(height: 10)
        ]
      )
    );
  }
}