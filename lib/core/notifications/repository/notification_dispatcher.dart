import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/booking/presentation/manager/booking_bloc.dart';
import '../../features/booking/presentation/manager/booking_event.dart';
import '../../features/owner_booking/presentation/manager/owner_booking_bloc.dart';
import '../routing/app_router.dart';
import 'notification_payload.dart';

class NotificationDispatcher {
  static void dispatch(NotificationPayload payload) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    if (payload.type != NotificationType.booking) return;

    if (payload.userRole == 'tenant') {
      context.read<BookingBloc>().add(GetUserBookingsEvent());
      return;
    }

    // OWNER
    switch (payload.action) {
      case BookingAction.newBooking:
      case BookingAction.approved:
      case BookingAction.rejected:
        context.read<OwnerBookingBloc>().add(LoadOwnerBookings());
        break;

      case BookingAction.updateRequest:
      case BookingAction.updateApproved:
      case BookingAction.updateRejected:
        context.read<OwnerBookingBloc>().add(LoadOwnerUpdateRequests());
        break;

      default:
        break;
    }
  }
}

// class NotificationDispatcher {
//   static void dispatch(NotificationPayload payload) {
//     final context = rootNavigatorKey.currentContext;
//     if (context == null) return;
//
//      switch (payload.type) {
//        case NotificationType.booking:
//          _handleBooking(context, payload);
//           break;
//        case NotificationType.review:
//
//           throw UnimplementedError();
//        case NotificationType.payment:
//
//           throw UnimplementedError();
//        case NotificationType.unknown:
//
//           throw UnimplementedError();
//     }
//   }
//
//  static void _handleBooking(
//       BuildContext context,
//       NotificationPayload payload,
//       ) {
//     /// Tenant side
//     if (payload.userRole == 'tenant') {
//       context.read<BookingBloc>().add(GetUserBookingsEvent());
//     }
//
//     /// Owner side
//     context.read<OwnerBookingBloc>().add(LoadOwnerBookings());
//     context.read<OwnerBookingBloc>().add(LoadOwnerUpdateRequests());
//   }
//
// }
