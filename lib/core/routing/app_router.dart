import 'package:sakan_go/core/routing/routes_name.dart';
import '../../features/Review/presentation/manager/rating/rating_bloc.dart';
import '../../features/Review/presentation/manager/review/review_bloc.dart';
import '../../features/Review/presentation/pages/create_review_page.dart';
import '../../features/booking/presentation/manager/booking_bloc.dart';
import '../../features/booking/presentation/manager/booking_event.dart';
import '../../features/booking/presentation/pages/booking_details_page.dart';
import '../../features/booking/presentation/pages/booking_playground_page.dart';
import '../../features/booking/presentation/pages/bookings_page.dart';
import '../../features/booking/presentation/pages/cancel_booking_page.dart';
import '../../features/booking/presentation/pages/create_booking_page.dart';
import '../../features/booking/presentation/pages/update_booking_page.dart';
import '../../features/booking/domain/entities/booking_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/booking/presentation/widgets/booking_permissions.dart';
import '../../features/owner_booking/presentation/manager/owner_booking_bloc.dart';
import '../../features/owner_booking/presentation/pages/owner_booking_tabs_page.dart';
import '../injector/injection_container.dart';
// ===== AUTH / INTRO =====
import '../../features/app_intro/presentation/pages/splash_page.dart';
import '../../features/app_intro/presentation/pages/onboarding_page.dart';
import '../../features/app_intro/presentation/bloc/splash/splash_bloc.dart';
import '../../features/app_intro/presentation/bloc/onboarding/onboarding_bloc.dart';

import '../../features/auth/presentation/pages/phone_number_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

import '../../features/admin_approval/presentation/pages/admin_approval_page.dart';
import '../../features/admin_approval/presentation/bloc/admin_approval_bloc.dart';

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/booking-playground',
    routes: [
      GoRoute(
        path: '/booking-playground',
        builder: (_, __) => const BookingPlaygroundPage(),
      ),

      // /// 🚀 SPLASH
      // GoRoute(
      //   path: RouteName.splash,
      //   builder: (_, __) => BlocProvider(
      //     create: (_) => di<SplashBloc>(),
      //     child: const SplashPage(),
      //   ),
      // ),
      //
      // /// 👋 ONBOARDING
      // GoRoute(
      //   path: RouteName.onboarding,
      //   builder: (_, __) => BlocProvider(
      //     create: (_) => di<OnboardingBloc>(),
      //     child: const OnboardingPage(),
      //   ),
      // ),
      //
      // /// 📞 PHONE NUMBER
      // GoRoute(
      //   path: RouteName.phoneNumber,
      //   builder: (_, __) => BlocProvider(
      //     create: (_) => di<AuthBloc>(),
      //     child: PhoneNumberPage(),
      //   ),
      // ),
      //
      // /// 🔐 OTP
      // GoRoute(
      //   path: RouteName.otpVerification,
      //   builder: (_, state) {
      //     final extra = state.extra;
      //
      //     if (extra == null || extra is! Map<String, String>) {
      //       return const _MissingDataPage();
      //     }
      //
      //     return BlocProvider(
      //       create: (_) => di<AuthBloc>(),
      //       child: OtpPage(
      //         phoneNumber: extra['phone_number']!,
      //         countryCode: extra['country_code']!,
      //       ),
      //     );
      //   },
      // ),
      //
      // /// 👤 PROFILE
      // GoRoute(
      //   path: RouteName.completeProfile,
      //   builder: (_, __) => BlocProvider(
      //     create: (_) => di<ProfileBloc>(),
      //     child: const ProfilePage(),
      //   ),
      // ),
      //
      // /// 🛂 ADMIN APPROVAL
      // GoRoute(
      //   path: RouteName.approval,
      //   builder: (_, __) => BlocProvider(
      //     create: (_) => di<AdminApprovalBloc>(),
      //     child: const AdminApprovalPage(),
      //   ),
      // ),
      /// 🏠 HOME (placeholder)
      // GoRoute(
      //   path: RouteName.home,
      //   builder: (_, __) => const Placeholder(),
      // ),
      // ============================================================
      // ======================= BOOKINGS ===========================
      // ============================================================

      /// 📋 BOOKINGS LIST
      GoRoute(
        path: RouteName.bookings,
        builder: (_,_) => BlocProvider(
          create: (_) => di<BookingBloc>()..add(GetUserBookingsEvent()),
          child:   BookingsPage(),
        ),
      ),

      /// ➕ CREATE BOOKING
      GoRoute(
        path: RouteName.createBooking,
        builder: (_, state) {
          final extra = state.extra;

          if (extra == null || extra is! Map<String, dynamic>) {
            return const _MissingDataPage();
          }

          return BlocProvider.value(
            value: di<BookingBloc>(),
            child: CreateBookingPage(
              apartment_id: extra['apartmentId'],
              user_id: extra['userId'],

            ),
          );
        },
      ),

      /// ✏️ UPDATE BOOKING
      GoRoute(
        path: RouteName.updateBooking,
        builder: (_, state) {

          if (state.extra == null || state.extra is! BookingEntity) {
            return const _MissingDataPage();
          }
          final booking = state.extra as BookingEntity;
          return BlocProvider.value(
            value: di<BookingBloc>(),
            child: UpdateBookingPage(
              booking_id: booking.id,
              initialStart: booking.start_date,
              initialEnd: booking.end_date,
            ),
          );

        },
      ),


      /// 📄 BOOKING DETAILS
      GoRoute(
        path: RouteName.Bookingdetail,
        builder: (_, state) {
          if (state.extra == null || state.extra is! BookingEntity) {
            return const _MissingDataPage();
          }

          return BookingDetailsPage(
            booking: state.extra as BookingEntity,
          );
        },
      ),
      /// 🚫 CANCEL BOOKING
      GoRoute(
        path: RouteName.Bookingcancel,
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CancelBookingPage(bookingId: id);
        },
      ),
      GoRoute(
        path: RouteName.Ownerbookings,
        builder: (_, __) => BlocProvider(
          create: (_) => di<OwnerBookingBloc>(),
          child: const OwnerBookingsTabsPage(),
        ),
      ),

      GoRoute(
        path: RouteName.createReview,
        builder: (context, state) {
          final bookingId =
          int.parse(state.pathParameters['bookingId']!);
          final apartmentId =
          int.parse(state.pathParameters['apartmentId']!);
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => di<ReviewBloc>(),
              ),
              BlocProvider(
                create: (_) => di<RatingBloc>(),
              ),
            ],
            child: CreateReviewPage(
              booking_id: bookingId,
              apartmentId: apartmentId,
            ),
          );

        },
      ),
    ],
  );
}

/// 🧯 Fallback page
class _MissingDataPage extends StatelessWidget {
  const _MissingDataPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Invalid navigation data'),
      ),
    );
  }
}
