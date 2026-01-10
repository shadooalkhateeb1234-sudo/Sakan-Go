import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../../../core/assets manager/images_manager.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/routes_name.dart';
import '../bloc/onboarding/onboarding_event.dart';
import '../bloc/onboarding/onboarding_state.dart';
import '../widgets/onboarding_action_button.dart';
import '../bloc/onboarding/onboarding_bloc.dart';
import '../widgets/onboarding_back_button.dart';
import '../widgets/onboarding_skip_button.dart';
import '../widgets/onboarding_page_item.dart';
import '../widgets/onboarding_dots.dart';

class OnboardingPage extends StatefulWidget
{
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
{
  final PageController _controller = PageController();
  int _index = 0;
  late final pages =
  [
    {'title': "Onboarding1".tr(context), 'image': ImagesManager.onboarding1},
    {'title': "Onboarding2".tr(context), 'image': ImagesManager.onboarding2},
    {'title': "Onboarding3".tr(context), 'image': ImagesManager.onboarding3},
  ];

  void _next()
  {
    if (_index < pages.length - 1)
    {
      _controller.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
    }
    else
    {
      context.read<OnboardingBloc>().add(OnboardingCompletedEvent());
    }
  }

  void _previous()
  {
    if (_index > 0)
    {
      _controller.previousPage(duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
    }
  }

  void _completeOnboarding() async
  {
    context.read<OnboardingBloc>().add(OnboardingCompletedEvent());
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return BlocListener<OnboardingBloc, OnboardingState>
    (
      listener: (context, state)
      {
        if (state is OnboardingSuccessState)
        {
          context.go(RouteName.phoneNumber);
        }

        if (state is OnboardingErrorState)
        {
          final message = state.message.tr(context);
          ScaffoldMessenger.of(context).showSnackBar
          (
              SnackBar(content: Text(message))
          );
        }
      },
      child: Scaffold
      (
        backgroundColor: colors.secondary,
        body: SafeArea
        (
          child: Column
          (
            children:
            [
              Container
              (
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: colors.secondary,
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    OnboardingBackButton(onPressed: _previous),
                    OnboardingSkipButton(onPressed: _completeOnboarding),
                  ],
                )
              ),

              Expanded
              (
                child: PageView.builder
                (
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemCount: pages.length,
                  itemBuilder: (_, i)
                  {
                    final page = pages[i];
                    return OnboardingPageItem
                    (
                      title: page['title']!,
                      image: page['image']!,
                    );
                  },
                ),
              ),

              OnboardingDots(length: pages.length, index: _index),

              const SizedBox(height: 30),

              Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OnboardingActionButton(isLast: _index == pages.length - 1, onPressed: _next)
              ),

              const SizedBox(height: 40)
            ]
          )
        )
      )
    );
  }
}