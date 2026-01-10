import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitions {
  static CustomTransitionPage fade({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage slideFromRight({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage scale({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: child,
        );
      },
    );
  }
}
//
// class AppTransitions {
//   static CustomTransitionPage fade({
//     required Widget child,
//     LocalKey? key,
//   }) {
//     return CustomTransitionPage(
//       key: key,
//       child: child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//     );
//   }
//
//   static CustomTransitionPage slideFromRight({
//     required Widget child,
//     LocalKey? key,
//   }) {
//     return CustomTransitionPage(
//       key: key,
//       child: child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         final tween = Tween(
//           begin: const Offset(1, 0),
//           end: Offset.zero,
//         ).chain(CurveTween(curve: Curves.easeOutCubic));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
// }
