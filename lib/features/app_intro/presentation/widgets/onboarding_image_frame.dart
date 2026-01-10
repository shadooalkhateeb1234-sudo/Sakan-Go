import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingImageFrame extends StatelessWidget
{
  final String image;
  final double width;
  final double height;

  const OnboardingImageFrame({super.key, required this.image, this.width = 250, this.height = 300});

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      width: width,
      height: height,
      decoration: BoxDecoration
      (
        color: Colors.blue.shade50,
        borderRadius: const BorderRadius.only
        (
          topLeft: Radius.circular(140),
          topRight: Radius.circular(140),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40)
        )
      ),
      child: ClipRRect
      (
        borderRadius: const BorderRadius.only
        (
          topLeft: Radius.circular(140),
          topRight: Radius.circular(140),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40)
        ),
        child: Image.asset
        (
          image,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter
        )
      )
    );
  }
}