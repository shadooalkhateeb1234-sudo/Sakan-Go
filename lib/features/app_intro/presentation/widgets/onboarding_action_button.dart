import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';

class OnboardingActionButton extends StatelessWidget
{
  final bool isLast;
  final VoidCallback onPressed;

  const OnboardingActionButton({super.key, required this.isLast, required this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: const EdgeInsets.symmetric(horizontal: 58),
      child: SizedBox
      (
        width: double.infinity,
        height: 60,
        child: ElevatedButton
        (
          onPressed: onPressed,
          child: Text(isLast ? "Get Started".tr(context) : "Next".tr(context))
        )
      )
    );
  }
}