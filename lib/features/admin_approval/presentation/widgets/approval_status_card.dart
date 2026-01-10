import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ApprovalStatusCard extends StatelessWidget
{
  final String iconPath;
  final String title;
  final String subtitle;
  final String backgroundSvg;
  final Widget? actionButton;
  final bool isLoading;

  const ApprovalStatusCard
  ({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.backgroundSvg,
    this.actionButton,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context)
  {
    return Stack
    (
      alignment: Alignment.center,
      children:
      [
        SvgPicture.asset
        (
          backgroundSvg,
          width: double.infinity,
          fit: BoxFit.cover
        ),
        Container
        (
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration
          (
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow:
            [
              BoxShadow
              (
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10)
              )
            ]
          ),
          child: Column
          (
            mainAxisSize: MainAxisSize.min,
            children:
            [
              SvgPicture.asset(iconPath, height: 80),
              const SizedBox(height: 24),

              Text
              (
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith
                (
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center
              ),

              const SizedBox(height: 12),

              Text
              (
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith
                (
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center
              ),

              if (isLoading) ...
              [
                const SizedBox(height: 24),
                const CircularProgressIndicator()
              ],

              if (actionButton != null) ...
              [
                const SizedBox(height: 32),
                actionButton!
              ]
            ]
          )
        )
      ]
    );
  }
}