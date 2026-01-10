import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/assets manager/images_manager.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/styles/app_colors.dart';

class SplashPageView extends StatefulWidget
{
  const SplashPageView({super.key});

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView>
{
  String? appVersion;

  get PackageInfo => null;

  @override
  void initState()
  {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async
  {
    final platformInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() => appVersion = platformInfo.version);
  }

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container
    (
      color: colors.tertiary,
      child: SafeArea
      (
        child: Stack
        (
          children:
          [
            Center
            (
              child: Column
              (
                mainAxisSize: MainAxisSize.min,
                children:
                [
                  ImageIcon
                  (
                    AssetImage(ImagesManager.appLogo),
                    size: 140,
                    color: AppColors.slate100
                  ),

                  const SizedBox(height: 10),

                  Text
                  (
                    "App Name".tr(context),
                    style: textTheme.headlineMedium?.copyWith
                    (
                      color: AppColors.slate100,
                      fontSize: 28,
                      fontWeight: FontWeight.w600
                    )
                  ),

                  const SizedBox(height: 80),

                  LoadingAnimationWidget.staggeredDotsWave
                  (
                    color: AppColors.slate100,
                    size: 70
                  )
                ]
              )
            ),
            Positioned
            (
              bottom: 30,
              left: 0,
              right: 0,
              child: Center
              (
                child: Text
                (
                  appVersion == null ? '' : 'v$appVersion',
                  style: TextStyle
                  (
                    color: AppColors.slate100
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}