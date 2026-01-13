import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_router.dart';
import 'notification_payload.dart';


class NotificationNavigator {
  static void navigate(NotificationPayload payload) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    if (payload.type != NotificationType.booking) return;

    if (payload.userRole == 'tenant') {
      context.go('/my-bookings');
      return;
    }

    // OWNER
    switch (payload.action) {
      case BookingAction.updateRequest:
      case BookingAction.updateApproved:
      case BookingAction.updateRejected:
        context.go('/owner/bookings?tab=updates');
        break;

      default:
        context.go('/owner/bookings');
    }
  }
  
}
