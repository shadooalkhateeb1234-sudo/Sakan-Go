import 'package:flutter/material.dart';

class OnboardingBubbles extends StatelessWidget
{
  const OnboardingBubbles({super.key});

  @override
  Widget build(BuildContext context)
  {
    final width = MediaQuery.of(context).size.width;

    return Stack
    (
      clipBehavior: Clip.none,
      children:
      [
        _bubble(left: width * 0.05, top: 20, size: 12),
        _bubble(right: width * 0.09, top: 50, size: 16),
        _bubble(left: width * 0.1, top: 80, size: 35),
        _bubble(right: width * 0.15, top: 190, size: 18),
        _bubble(left: width * 0.1, bottom: 100, size: 15),
        _bubble(right: width * 0.12, bottom: 3, size: 30),
        _bubble(left: width * 0.25, top: 1, size: 60),
        _bubble(right: width * 0.05, bottom: 150, size: 30),
        _bubble(left: width * 0.12, bottom: 10, size: 50)
      ],
    );
  }

  Widget _bubble({double? left, double? right, double? top, double? bottom, required double size})
  {
    return Positioned
    (
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container
      (
        width: size,
        height: size,
        decoration: BoxDecoration
        (
          color: Colors.blue.withOpacity(0.15),
          shape: BoxShape.circle
        )
      )
    );
  }
}