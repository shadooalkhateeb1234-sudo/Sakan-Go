import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/route_name.dart';

class AuthBackButton extends StatelessWidget
{

  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Align
      (
        alignment: Alignment.topLeft,
        child: IconButton
          (
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: colors.primary,
            onPressed: () => context.go(RouteName.phoneNumber)
        )
    );
  }
}