import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResendOtpText extends StatelessWidget
{
  final int seconds;
  final VoidCallback? onResend;

  const ResendOtpText({super.key, required this.seconds, required this.onResend});

  @override
  Widget build(BuildContext context)
  {
    return Center(child: seconds > 0
          ? Text(
        'Resend code in $seconds s',
        style: const TextStyle(color: Colors.grey),
      )
          : GestureDetector(
        onTap: onResend,
        child: const Text(
          'Resend Code',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
