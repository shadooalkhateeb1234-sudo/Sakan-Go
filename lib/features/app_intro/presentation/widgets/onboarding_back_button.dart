import 'package:flutter/material.dart';

class OnboardingBackButton extends StatelessWidget
{
  final VoidCallback onPressed;

  const OnboardingBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Align
    (
      alignment: Alignment.topLeft,
      child: IconButton
      (
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: colors.primary,
        onPressed: onPressed
      )
    );
  }
}