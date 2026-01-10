import 'package:flutter/material.dart';

class AuthBubbles extends StatelessWidget
{
  const AuthBubbles({super.key});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Stack
    (
      children:
      [
        Container(color: colors.secondaryContainer),

        Positioned
        (
          bottom: 60,
          left: 100,
          child: _circle
          (
            size: 50,
            color: colors.primary.withOpacity(0.1)
          )
        ),

        Positioned
        (
          bottom: -20,
          left: -15,
          child: _circle
          (
            size: 120,
            color: colors.primary
          )
        )
      ]
    );
  }

  Widget _circle({required double size, required Color color,})
  {
    return Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color));
  }
}