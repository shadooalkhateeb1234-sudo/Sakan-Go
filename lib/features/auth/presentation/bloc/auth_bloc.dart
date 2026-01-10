import 'package:bloc/bloc.dart';

import '../../domain/use_cases/send_phone_otp_use_case.dart';
import '../../domain/use_cases/resend_phone_otp_use_case.dart';
import '../../domain/use_cases/verify_phone_otp_use_case.dart';
import '../../domain/use_cases/refresh_token_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../../../core/errors/failures.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendPhoneOtpUseCase sendPhoneOtpUseCase;
  final ResendPhoneOtpUseCase resendPhoneOtpUseCase;
  final VerifyPhoneOtpUseCase verifyPhoneOtpUseCase;
  final LogoutUseCase logoutUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;

  AuthBloc({required this.sendPhoneOtpUseCase, required this.resendPhoneOtpUseCase, required this.verifyPhoneOtpUseCase, required this.logoutUseCase, required this.refreshTokenUseCase}) : super(AuthInitial())
  {
    on<SendOtpEvent>(_onSendOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<LogoutEvent>(_onLogout);
    on<RefreshTokenEvent>(_onRefreshToken);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async
  {
    emit(AuthLoading());
    final result = await sendPhoneOtpUseCase(phoneNumber: event.phoneNumber, countryCode: event.countryCode);
    //debug
    print('SEND OTP EVENT >>> phone number: ${event.phoneNumber}, country code: ${event.countryCode}');

    result.fold
    (
      (failure) => _mapFailure(failure, emit),
      (auth)
      {
        emit(OtpSentSuccess(auth: auth));
      }
    );
  }

  Future<void> _onResendOtp(ResendOtpEvent event, Emitter<AuthState> emit) async
  {
    emit(AuthLoading());
    final result = await resendPhoneOtpUseCase(phoneNumber: event.phoneNumber, countryCode: event.countryCode);
    //debug
    print('RESEND OTP EVENT >>> phone number: ${event.phoneNumber}, country code: ${event.countryCode}');

    result.fold
    (
      (failure) => _mapFailure(failure, emit),
      (auth)
      {
        emit(OtpSentSuccess(auth: auth));
      }
    );
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async
  {
    emit(AuthLoading());
    final result = await verifyPhoneOtpUseCase(phoneNumber: event.phoneNumber, countryCode: event.countryCode, otp: event.otp);
    //debug
    print('VERIFY_OTP EVENT >>> phone number: ${event.phoneNumber}, country code: ${event.countryCode}, otp: ${event.otp}');

    result.fold
    (
      (failure) => _mapFailure(failure, emit),
      (session)
      {
       emit(OtpVerifiedSuccess(session: session));
      }
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit,) async
  {
    emit(AuthLoading());
    final result = await logoutUseCase();

    result.fold
    (
      (failure) => _mapFailure(failure, emit),
      (_)
      {
        emit(AuthActionSuccess());
        // debug
        print("logout successfully");
      }
    );
  }

  Future<void> _onRefreshToken(RefreshTokenEvent event, Emitter<AuthState> emit) async
  {
    final result = await refreshTokenUseCase();
    result.fold((_) {}, (_) {});
  }

  void _mapFailure(Failure failure, Emitter<AuthState> emit)
  {
    if (failure is UnprocessableEntityFailure)
    {
      //emit(AuthValidationError(fieldErrors: failure.fieldErrors));
    }
    else if (failure is TooManyRequestFailure)
    {
      //emit(OtpBlocked(resendAfterSeconds: failure.resendAfterSeconds));
    }

    else if (failure is GoneFailure)
    {
      emit(OtpExpired());
    }
    else if (failure is OfflineFailure)
    {
      emit(const AuthFailureState(message: 'No internet connection'));
    }
    else if (failure is UnAuthorizedFailure)
    {
      emit(const AuthFailureState(message: 'Session expired'));
    }
    else
    {
      emit(const AuthFailureState(message: 'Something went wrong'));
    }
  }
}