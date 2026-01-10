import 'package:flutter/material.dart';

class AnimatedStars extends StatelessWidget {
  final double average;

  const AnimatedStars({super.key, required this.average});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final value = index + 1;

          IconData icon;
          if (average >= value) {
            icon = Icons.star;
          } else if (average >= value - 0.5) {
            icon = Icons.star_half;
          } else {
            icon = Icons.star_border;
          }

          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 300 + index * 120),
            builder: (_, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Opacity(opacity: scale, child: child),
              );
            },
            child: Icon(
              icon,
              color: Colors.amber,
              size: 22,
            ),
          );
        }),
        const SizedBox(width: 6),
        Text(
          average.toStringAsFixed(1),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
