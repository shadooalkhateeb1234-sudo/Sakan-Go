import 'package:flutter/material.dart';
import 'dart:io';

class PersonalImagePicker extends StatelessWidget
{
  final File? personalImage;
  final VoidCallback onTap;

  const PersonalImagePicker({super.key, required this.personalImage, required this.onTap});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Positioned
    (
      top: 140,
      left: 0,
      right: 0,
      child: Center
      (
        child: GestureDetector
        (
          onTap: onTap,
          child: Stack
          (
            alignment: Alignment.bottomRight,
            children:
            [
              CircleAvatar
              (
                radius: 80,
                backgroundColor: colors.secondaryContainer,
                child: CircleAvatar
                (
                  radius: 76,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                  personalImage != null ? FileImage(personalImage!) : null,
                  child: personalImage == null ? const Icon
                  (
                    Icons.person,
                    size: 110,
                    color: Colors.grey
                  ) : null
                )
              ),
              Positioned
              (
                bottom: 5,
                right: 10,
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    shape: BoxShape.circle,
                    color: colors.primary,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon
                  (
                    Icons.add,
                    size: 20,
                    color: colors.secondaryContainer
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
