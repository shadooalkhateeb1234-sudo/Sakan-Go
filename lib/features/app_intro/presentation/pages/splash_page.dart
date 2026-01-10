import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../../core/routing/route_name.dart';
import '../bloc/splash/splash_decision.dart';
import '../bloc/splash/splash_event.dart';
import '../bloc/splash/splash_state.dart';
import '../widgets/splash_page_view.dart';
import '../bloc/splash/splash_bloc.dart';

class SplashPage extends StatefulWidget
{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage>
{
  
  @override
  void initState()
  {
    super.initState();

    Future.delayed(const Duration(seconds: 5), ()
    {
      context.read<SplashBloc>().add(GetUserSessionEvent());
    });
  }

  void _handleNavigation(BuildContext context, SplashDecision splashDecision)
  {
    switch (splashDecision)
    {
      case SplashDecision.onboarding:
        context.go(RouteName.onboarding);
        break;

      case SplashDecision.phoneNumber:
        context.go(RouteName.phoneNumber);
        break;

      case SplashDecision.completeProfile:
        context.go(RouteName.completeProfile);
        break;

      case SplashDecision.approval:
        context.go(RouteName.approval);
        break;

      case SplashDecision.home:
        context.go(RouteName.home);
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: BlocListener<SplashBloc, SplashState>
      (
        listener: (context, state)
        {
          if (state is SplashNavigate)
          {
            _handleNavigation(context, state.splashDecision);
          }

          if (state is SplashError)
          {
            final message = state.message.tr(context);
            ScaffoldMessenger.of(context).showSnackBar
            (
              SnackBar(content: Text(message))
            );
          }
        },
        child: Center
        (
          child: SplashPageView()
        )
      )
    );
  }
}