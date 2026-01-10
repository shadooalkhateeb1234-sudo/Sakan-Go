import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget
{
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const PrimaryActionButton({super.key, required this.text, this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context)
  {
    return SizedBox
    (
      height: 55,
      child: ElevatedButton
      (
        onPressed: loading ? null : onPressed,
        child: loading ? const CircularProgressIndicator(strokeWidth: 2) : Text(text)
      )
    );
  }
}