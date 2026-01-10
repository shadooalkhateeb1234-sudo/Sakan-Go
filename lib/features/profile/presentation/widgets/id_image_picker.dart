import 'package:flutter/material.dart';

class IdImagePicker extends StatelessWidget
{
  final bool selected;
  final VoidCallback onTap;

  final double borderWidth;
  final Color enabledBorderColor;
  final Color selectedBorderColor;
  final double borderRadius;

  const IdImagePicker
  ({
    super.key,
    required this.selected,
    required this.onTap,
    this.borderWidth = 2.0,
    this.enabledBorderColor = Colors.grey,
    this.selectedBorderColor = Colors.blue,
    this.borderRadius = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: selected ? selectedBorderColor : enabledBorderColor,
            width: borderWidth,
          ),
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? Icons.check_circle : Icons.badge,
                size: 30,
                color: selected ? selectedBorderColor : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                "Upload ID Image",
                style: TextStyle(
                  color: selected ? selectedBorderColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
