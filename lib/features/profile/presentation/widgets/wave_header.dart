 import 'package:flutter/material.dart';

class WaveHeader extends StatelessWidget
{
  const WaveHeader({super.key});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return ClipPath
    (
       // clipper: OvalBottomBorderClipper(),
        child: Container
        (
            height: 230,
            decoration: BoxDecoration
            (
                color: colors.primary
            )
        )
    );
  }
}
