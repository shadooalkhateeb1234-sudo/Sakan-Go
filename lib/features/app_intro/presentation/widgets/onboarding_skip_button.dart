import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';

class OnboardingSkipButton extends StatelessWidget
{
  final VoidCallback onPressed;

  const OnboardingSkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    return Align
    (
      alignment: Alignment.topRight,
      child: TextButton
      (
        onPressed: onPressed,
        child: Text("Skip".tr(context))
      )
    );
  }
}