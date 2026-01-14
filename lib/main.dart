import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/firebase/firebase_initialize.dart';
import 'core/localization/app_localizations.dart';
import 'core/notifications/firebase_notification_service.dart';
import 'core/notifications/notifications_initialize.dart';
import 'core/notifications/presentation/blocs/notification_bloc.dart';
import 'core/routing/app_router.dart';
import 'core/styles/app_theme.dart';
import 'core/injector/injection_container.dart' ;
import 'features/booking/presentation/manager/booking_bloc.dart';
import 'features/language/bloc/language_bloc.dart';
import 'features/language/bloc/language_event.dart';
import 'features/language/bloc/language_state.dart';
import 'features/owner_booking/presentation/manager/owner_booking_bloc.dart';
import 'features/theme/bloc/theme_bloc.dart';
import 'features/theme/bloc/theme_event.dart';
import 'features/theme/bloc/theme_state.dart';
import 'features/theme/domain/entities/theme_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseNotificationService.instance.init();

  //هي لازم بعد ال login
  //await FirebaseNotificationService.instance.init(context);

  await  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

   return MultiBlocProvider
      (
        providers:
        [
          //BlocProvider(create: (_) => NotificationBloc()),
          BlocProvider(create: (_) => di<OwnerBookingBloc>()),
          BlocProvider(create: (_) => di<BookingBloc>()),
          BlocProvider
            (
              create: (_) => di<LanguageBloc>()..add(GetLanguageEvent())
          ),
          BlocProvider
            (
              create: (_) => di<ThemeBloc>()..add(GetThemeEvent())
          )
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>
          (
            builder: (context, languageState)
            {
              return BlocBuilder<ThemeBloc, ThemeState>
                (
                  builder: (context, themeState) {
                    final isDark = themeState.themeEntity?.themeType ==
                        ThemeType.dark;

                    return MaterialApp.router
                      (
                        debugShowCheckedModeBanner: false,
                        routerConfig: AppRouter.appRouter,
                        locale: languageState.languageEntity == null
                            ? const Locale('en')
                            : Locale(
                            languageState.languageEntity!.languageType.name),

                        supportedLocales: const
                        [
                          Locale('en'),
                          Locale('ar')
                        ],
                        localizationsDelegates: const
                        [
                          AppLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate
                        ],

                        theme: AppTheme.light,
                        darkTheme: AppTheme.dark,
                        themeMode: isDark ? ThemeMode.dark : ThemeMode.light
                    );

                  }
              );
            }
        )
    );
  }
}

