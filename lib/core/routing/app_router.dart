import 'package:go_router/go_router.dart';
import 'package:sakan_go/core/routing/routes_name.dart';

class AppRouter
{
  static final GoRouter router = GoRouter(
    initialLocation: RoutesName.home,
    routes: [
      GoRoute(
        path: RoutesName.home,
        //builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutesName.splash,
        //builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}
