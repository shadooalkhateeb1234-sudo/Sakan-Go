import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBar
{
  static void showError(BuildContext context, String message)
  {
    final colors = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).showSnackBar
    (
      SnackBar
      (
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: colors.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}