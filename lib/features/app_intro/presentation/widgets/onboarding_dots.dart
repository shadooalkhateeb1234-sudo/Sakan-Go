import 'package:flutter/material.dart';

class OnboardingDots extends StatelessWidget
{
  final int length;
  final int index;

  const OnboardingDots({super.key, required this.length, required this.index});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate
      (
        length,
        (i) => AnimatedContainer
        (
          duration: const Duration(milliseconds: 50),
          margin: const EdgeInsets.all(4),
          width: index == i ? 22 : 12,
          height: 12,
          decoration: BoxDecoration
          (
            color: index == i ? colors.primary : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)
          )
        )
      )
    );
  }
}