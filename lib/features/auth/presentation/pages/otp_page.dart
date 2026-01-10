import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/assets_manager/icons_manager.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_name.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_bubbles.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;

  const OtpPage({
    super.key,
    required this.phoneNumber,
    required this.countryCode,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  Timer? _timer;
  int _secondsLeft = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer([int seconds = 30]) {
    _timer?.cancel();
    setState(() => _secondsLeft = seconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AuthBubbles(),
          const AuthBackButton(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OtpBlocked) {
                    _startTimer(state.resendAfterSeconds.toInt());
                  }

                  if (state is OtpInvalid) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid OTP')),
                    );
                  }

                  if (state is OtpExpired) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('OTP expired')),
                    );
                  }

                  if (state is AuthFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }

                  if (state is OtpVerifiedSuccess) {
                    final session = state.session;

                    if (session.isProfileCompleted == true)
                    {
                      context.go(RouteName.home);
                    }
                    else
                    {
                      context.go(RouteName.completeProfile);
                    }
                  }
                },
                builder: (context, state) {
                  final loading = state is AuthLoading;

                  return SingleChildScrollView(
                    reverse: true,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        SizedBox(height: 50),

                        SvgPicture.asset
                          (
                            IconsManager.registration,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.contain
                        ),

                        SizedBox(height: 20),
                        const SizedBox(height: 260),

                        Text(
                          "Registration".tr(context),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enter the OTP sent to ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            Text(
                              "${widget.countryCode} ${widget.phoneNumber}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.scale,
                          enableActiveFill: false,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          pinTheme: PinTheme
                            (
                            shape: PinCodeFieldShape.circle,
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeColor: Theme.of(context).colorScheme.primary,
                            selectedColor:
                            Theme.of(context).colorScheme.primary,
                            inactiveColor: Colors.grey,
                          ),
                          onChanged: (_) {},
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: _secondsLeft > 0
                              ? Text(
                            "Resend code in $_secondsLeft s",
                            style: TextStyle(
                                color: Colors.grey.shade600),
                          )
                              : TextButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                ResendOtpEvent(
                                  phoneNumber: widget.phoneNumber,
                                  countryCode: widget.countryCode,
                                ),
                              );
                              _startTimer();
                            },
                            child: const Text("Resend code"),
                          ),
                        ),

                        const SizedBox(height: 32),

                        PrimaryActionButton(
                          text: 'VERIFY & PROCEED',
                          loading: loading,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              VerifyOtpEvent(
                                phoneNumber: widget.phoneNumber,
                                countryCode: widget.countryCode,
                                otp: _otpController.text.trim(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
