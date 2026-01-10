import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sakan_go_mobile_app/core/assets_manager/icons_manager.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_name.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/auth_bubbles.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../bloc/auth_bloc.dart';

class PhoneNumberPage extends StatelessWidget
{
  PhoneNumberPage({super.key});

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    final colors = Theme.of(context).colorScheme;

    return Scaffold
    (
      body: GestureDetector
      (
        behavior: HitTestBehavior.translucent,
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child: Stack
        (

          children:
          [
            const AuthBubbles(),

            SafeArea
            (
              child: Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: BlocConsumer<AuthBloc, AuthState>
                (
                  listener: (context, state)
                  {
                    if (state is OtpSentSuccess)
                    {
                      context.go(RouteName.otpVerification,extra: { 'country_code': '+963', 'phone_number': phoneNumberController.text.trim()});
                    }
                    if (state is AuthFailureState)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state)
                  {
                    final loading = state is AuthLoading;

                    return SingleChildScrollView
                    (
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      reverse: true,
                      child: Column
                      (
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children:
                        [
                          SizedBox(height: 50),

                          SvgPicture.asset
                          (
                            IconsManager.registration,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.contain
                          ),

                          SizedBox(height: 20),

                          Text
                          (
                            "Registration".tr(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 25),
                          ),

                          const SizedBox(height: 5),

                          Text
                          (
                            "Enter your phone number to verify your account",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600, height: 1.4, fontSize: 12)
                          ),

                          const SizedBox(height: 20),

                          Container
                          (
                            padding: const EdgeInsets.all(19),
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration
                            (
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow:
                              [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 9)
                                )
                              ]
                            ),
                            child: Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              children:
                              [
                                const SizedBox(height: 20),

                                PhoneNumberField(controller: phoneNumberController),

                                PrimaryActionButton
                                (
                                  text: 'Continue',
                                  loading: loading,
                                  onPressed: ()
                                  {
                                    final phone = phoneNumberController.text.trim();

                                    if (!phone.startsWith('09') || phone.length != 10)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid phone number')),);
                                      return;
                                    }
                                    context.read<AuthBloc>().add(SendOtpEvent(phoneNumber: phone, countryCode: '+963'));
                                  }
                                ),

                                const SizedBox(height: 10),

                                Text
                                (
                                  "We won’t share your phone number with anyone.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500,fontSize: 10)
                                )
                              ]
                            )
                          )
                        ]
                      )
                    );
                  }
                )
              )
            )
          ]
        ),
      )
    );
  }
}