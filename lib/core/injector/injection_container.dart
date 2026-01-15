import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/Review/data/data_sources/review_remote_data_source.dart';
import '../../features/Review/data/repositories/review_repositpry_impl.dart';
import '../../features/Review/domain/repositories/review_repository.dart';
import '../../features/Review/domain/use_cases/create_review_usecase.dart';
import '../../features/Review/domain/use_cases/get_apartment_average_rating_usecase.dart';
import '../../features/Review/presentation/manager/rating/rating_bloc.dart';
import '../../features/Review/presentation/manager/review/review_bloc.dart';
import '../../features/admin_approval/data/remote/data_sources/admin_approval_remote_data_source.dart';
import '../../features/admin_approval/data/repositories/admin_approval_repository_impl.dart';
import '../../features/admin_approval/domain/repositories/admin_approval_repository.dart';
import '../../features/admin_approval/domain/use_cases/check_admin_approval_use_case.dart';
import '../../features/admin_approval/presentation/bloc/admin_approval_bloc.dart';
import '../../features/admin_upgrade/data/remote/data_sources/admin_upgrade_remote_data_source.dart';
import '../../features/admin_upgrade/data/repositories/admin_upgrade_repository_impl.dart';
import '../../features/admin_upgrade/domain/repositories/admin_upgrade_repository.dart';
import '../../features/admin_upgrade/domain/use_cases/check_admin_upgrade_use_case.dart';
import '../../features/admin_upgrade/domain/use_cases/submit_upgrade_use_case.dart';
import '../../features/admin_upgrade/presentation/bloc/admin_upgrade_bloc.dart';
import '../../features/app_intro/presentation/bloc/onboarding/onboarding_bloc.dart';
import '../../features/app_intro/presentation/bloc/splash/splash_bloc.dart';
import '../../features/auth/data/remote/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/logout_use_case.dart';
import '../../features/auth/domain/use_cases/refresh_token_use_case.dart';
import '../../features/auth/domain/use_cases/resend_phone_otp_use_case.dart';
import '../../features/auth/domain/use_cases/send_phone_otp_use_case.dart';
import '../../features/auth/domain/use_cases/verify_phone_otp_use_case.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/booking/domain/use_cases/request_booking_update.dart';
import '../../features/language/bloc/language_bloc.dart';
import '../../features/language/data/local/language_local_data_source.dart';
import '../../features/language/data/repositories/language_repository_impl.dart';
import '../../features/language/domain/repositories/language_repository.dart';
import '../../features/language/domain/use_cases/get_language_use_case.dart';
import '../../features/language/domain/use_cases/save_language_use_case.dart';
import '../../features/owner_booking/data/data_sources/owner_booking_remote_data_source.dart';
import '../../features/owner_booking/data/repositories/owner_booking_repository_impl.dart';
import '../../features/owner_booking/domain/repositories/owner_booking_repository.dart';
import '../../features/owner_booking/domain/use_cases/get_owner_update_requests.dart';
import '../../features/owner_booking/domain/use_cases/owner_approve_booking.dart';
import '../../features/owner_booking/domain/use_cases/owner_approve_update_request.dart';
import '../../features/owner_booking/domain/use_cases/owner_bookings_usecase.dart';
import '../../features/owner_booking/domain/use_cases/owner_reject_booking.dart';
import '../../features/owner_booking/domain/use_cases/owner_reject_update_request.dart';
import '../../features/owner_booking/presentation/manager/owner_booking_bloc.dart';
import '../../features/profile/data/remote/data_sources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/use_cases/show_profile_use_case.dart';
import '../../features/profile/domain/use_cases/submit_profile_use_case.dart';
import '../../features/profile/domain/use_cases/update_profile_use_case.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/data/local/theme_local_data_source.dart';
import '../../features/theme/data/repositories/theme_repository_impl.dart';
import '../../features/theme/domain/repositories/theme_repository.dart';
import '../../features/theme/domain/use_cases/get_theme_use_case.dart';
import '../../features/theme/domain/use_cases/save_theme_use_case.dart';
import '../../features/user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../features/user_session/data/repositories/user_session_repository_impl.dart';
import '../../features/user_session/domain/repositories/user_session_repository.dart';
import '../../features/user_session/domain/use_cases/cache_user_session_use_case.dart';
import '../../features/user_session/domain/use_cases/clear_user_session_use_case.dart';
import '../../features/user_session/domain/use_cases/get_user_session_use_case.dart';
import '../../features/user_session/domain/use_cases/set_onboarding_completed_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/booking/data/data_sources/booking_remote_data_source.dart';
import '../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../features/booking/domain/use_cases/create_booking_usecase.dart';
import '../../features/booking/domain/use_cases/cancel_booking_usecase.dart';
import '../../features/booking/domain/repositories/booking_repository.dart';
import '../../features/booking/domain/use_cases/get_bookings_usecase.dart';
import '../../features/booking/presentation/manager/booking_bloc.dart';
import '../network/network_info.dart';
import 'package:get_it/get_it.dart';


final di = GetIt.instance;

Future<void> init() async
{
  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton<InternetConnectionChecker>(() =>
      InternetConnectionChecker.createInstance());
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton<http.Client>(() => http.Client());

  // core
  di.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(connectionChecker: di()));

  // features

  // admin_approval
  // Data source
  di.registerLazySingleton<AdminApprovalRemoteDataSource>(() =>
      AdminApprovalRemoteDataSourceImpl(client: di()));
  // Repository
  di.registerLazySingleton<AdminApprovalRepository>(() =>
      AdminApprovalRepositoryImpl(adminApprovalRemoteDataSource: di(),
          userSessionLocalDataSource: di(),
          networkInfo: di()));
  // Use case
  di.registerLazySingleton(() =>
      CheckAdminApprovalUseCase(adminApprovalRepository: di()));
  // Bloc
  di.registerFactory(() => AdminApprovalBloc(checkAdminApprovalUseCase: di()));

  // admin_upgrade
  // Data source
  di.registerLazySingleton<AdminUpgradeRemoteDataSource>(() =>
      AdminUpgradeRemoteDataSourceImpl(client: di()));
  // Repository
  di.registerLazySingleton<AdminUpgradeRepository>(() =>
      AdminUpgradeRepositoryImpl(adminUpgradeRemoteDataSource: di(),
          userSessionLocalDataSource: di(),
          networkInfo: di()));
  // Use case
  di.registerLazySingleton(() =>
      CheckAdminUpgradeUseCase(adminUpgradeRepository: di()));
  di.registerLazySingleton(() =>
      SubmitUpgradeUseCase(adminUpgradeRepository: di()));
  // Bloc
  di.registerFactory(() =>
      AdminUpgradeBloc(
          checkAdminUpgradeUseCase: di(), submitUpgradeUseCase: di()));

  // app_intro
  // Bloc
  di.registerFactory(() => SplashBloc(getUserSessionUseCase: di()));
  di.registerFactory(() => OnboardingBloc(setOnboardingCompletedUseCase: di()));

  // auth
  // Data source
  di.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(client: di()));
  // Repository
  di.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(authRemoteDataSource: di(),
          userSessionLocalDataSource: di(),
          networkInfo: di()));
  // Use cases
  di.registerLazySingleton(() => SendPhoneOtpUseCase(authRepository: di()));
  di.registerLazySingleton(() => ResendPhoneOtpUseCase(authRepository: di()));
  di.registerLazySingleton(() => VerifyPhoneOtpUseCase(authRepository: di()));
  di.registerLazySingleton(() => LogoutUseCase(authRepository: di()));
  di.registerLazySingleton(() => RefreshTokenUseCase(authRepository: di()));
  // Bloc
  di.registerFactory(() =>
      AuthBloc(sendPhoneOtpUseCase: di(),
          resendPhoneOtpUseCase: di(),
          verifyPhoneOtpUseCase: di(),
          logoutUseCase: di(),
          refreshTokenUseCase: di()));

  // language
  // Data source
  di.registerLazySingleton<LanguageLocalDatasource>(() =>
      LanguageLocalDatasourceImpl(sharedPreferences: di()));
  // Repository
  di.registerLazySingleton<LanguageRepository>(() =>
      LanguageRepositoryImpl(languageLocalDatasource: di()));
  // Use case
  di.registerLazySingleton(() => GetLanguageUseCase(languageRepository: di()));
  di.registerLazySingleton(() => SaveLanguageUseCase(languageRepository: di()));
  //Bloc
  di.registerFactory(() =>
      LanguageBloc(getLanguageUseCase: di(), saveLanguageUseCase: di()));

  // profile
  // Data source
  di.registerLazySingleton<ProfileRemoteDataSource>(() =>
      ProfileRemoteDataSourceImpl(client: di()));
  // Repository
  di.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepositoryImpl(profileRemoteDataSource: di(),
          userSessionLocalDataSource: di(),
          networkInfo: di()));
  // Use Case
  di.registerLazySingleton(() => ShowProfileUseCase(profileRepository: di()));
  di.registerLazySingleton(() => SubmitProfileUseCase(profileRepository: di()));
  di.registerLazySingleton(() => UpdateProfileUseCase(profileRepository: di()));
  // Bloc
  di.registerFactory(() =>
      ProfileBloc(showProfileUseCase: di(),
          submitProfileUseCase: di(),
          updateProfileUseCase: di()));

  // theme
  // Data source
  di.registerLazySingleton<ThemeLocalDatasource>(() =>
      ThemeLocalDatasourceImpl(sharedPreferences: di()));
  // Repository
  di.registerLazySingleton<ThemeRepository>(() =>
      ThemeRepositoryImpl(themeLocalDatasource: di()));
  // Use case
  di.registerLazySingleton(() => GetThemeUseCase(themeRepository: di()));
  di.registerLazySingleton(() => SaveThemeUseCase(themeRepository: di()));
  //Bloc
  di.registerFactory(() =>
      ThemeBloc(getThemeUseCase: di(), saveThemeUseCase: di()));

  // user_session
  // Data source
  di.registerLazySingleton<UserSessionLocalDataSource>(() =>
      UserSessionLocalDataSourceImpl(sharedPreferences: di()));
  // Repository
  di.registerLazySingleton<UserSessionRepository>(() =>
      UserSessionRepositoryImpl(userSessionLocalDataSource: di()));
  // Use case
  di.registerLazySingleton(() =>
      CacheUserSessionUseCase(userSessionRepository: di()));
  di.registerLazySingleton(() =>
      ClearUserSessionUseCase(userSessionRepository: di()));
  di.registerLazySingleton(() =>
      GetUserSessionUseCase(userSessionRepository: di()));
  di.registerLazySingleton(() =>
      SetOnboardingCompletedUseCase(userSessionRepository: di()));

  //============================================================
  //======================= BOOKINGS ===========================
  //============================================================
  // BOOKINGS


  // Data source
    di.registerLazySingleton<BookingRemoteDataSource>(
          () => BookingRemoteDataSourceImpl(client: di() , userSessionLocalDataSource: di()),
    );

  // Repository
  di.registerLazySingleton<BookingRepository>(
        () =>
        BookingRepositoryImpl(
          remote: di(),
          networkInfo: di(),
          userSessionLocalDataSource: di(),
        ),
  );
  // Use case
  di.registerLazySingleton(() => CreateBookingUseCase(di()));
  di.registerLazySingleton(() => CancelBookingUseCase(di()));
  di.registerLazySingleton(() => GetUserBookingsUsecase(di()));
  di.registerLazySingleton(() => UpdateBookingUseCase(di()));

  //! Bloc
  di.registerFactory(
        () =>
        BookingBloc(
          createBooking: di(),
          cancelBooking: di(),
          getUserBookings: di(),
          updateBooking: di(),



        ),
  );
  //.................... Review........................
  // Data source
  di.registerLazySingleton<ReviewRemoteDataSource>(
        () =>
        ReviewRemoteDataSourceImpl(
            client: di(), userSessionLocalDataSource: di()),
  );
  // Repository
  di.registerLazySingleton<ReviewRepository>(
        () =>
        ReviewRepositoryImpl(
          remote: di(),
          networkInfo: di(),
          userSessionLocalDataSource: di(),
        ),
  );
  // Use case
  di.registerLazySingleton(() => CreateReviewUseCase(di()));
  di.registerLazySingleton(() => GetApartmentAverageRatingUseCase(di()));
  // Bloc
  di.registerFactory(
        () =>
        ReviewBloc(
          createReview: di(),
        ),
  );

  di.registerFactory(
        () => RatingBloc(
      getRating: di<GetApartmentAverageRatingUseCase>(),
      repository: di<ReviewRepository>(),
    ),
  );


//owner_booking..............
//data source
//   di.registerLazySingleton<OwnerBookingRemoteDataSource>(
//         () =>
//         OwnerBookingRemoteDataSourceImpl(
//             client: di(), userSessionLocalDataSource: di()),
//   );
  //repository
  di.registerLazySingleton<OwnerBookingRepository>(
        () =>
            OwnerBookingRepositoryImpl(
          remote: di(),
          networkInfo: di(),
          userSessionLocalDataSource: di(),
        ),
  );

// UseCases
    di.registerLazySingleton(() => GetOwnerBookings(di()));
    di.registerLazySingleton(() => ApproveBooking(di()));
    di.registerLazySingleton(() => RejectBooking(di()));
    di.registerLazySingleton(() => GetOwnerUpdateRequests(di()));
    di.registerLazySingleton(() => ApproveUpdateRequest(di()));
    di.registerLazySingleton(() => RejectUpdateRequest(di()));


  // Bloc
  di.registerFactory(() => OwnerBookingBloc(
    getBookings: di(),
    approveUpdateRequest: di(),
    rejectUpdateRequest: di(),
    approveBooking: di(),
    rejectBooking: di(),
    getUpdateRequests: di(),

  ));



}

//..................


