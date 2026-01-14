 // 'tenant' or 'owner'

enum NotificationType {
  booking,
  review,
  payment,
  unknown,
}


enum BookingAction {
  newBooking,
  approved,
  rejected,
  updateRequest,
  updateApproved,
  updateRejected,
  unknown,
}

class NotificationPayload {
  final NotificationType type;
  final BookingAction action;
  final int? bookingId;
  final int? apartmentId;
  final String userRole;
  NotificationPayload({
    required this.type,
    required this.action,
    required this.userRole,
    this.bookingId,
    this.apartmentId,
  });

  factory NotificationPayload.fromMap(Map<String, dynamic> data) {
    return NotificationPayload(
      type: _mapType(data['type']),
      action: _mapBookingAction(data['action']),
      userRole: data['user_role'] ?? 'tenant',
      bookingId: int.tryParse('${data['booking_id']}'),
      apartmentId: int.tryParse('${data['apartment_id']}'),
    );
  }



  static NotificationType _mapType(String? value) {
    switch (value) {
      case 'booking':
        return NotificationType.booking;
      case 'review':
        return NotificationType.review;
      case 'payment':
        return NotificationType.payment;
      default:
        return NotificationType.unknown;
    }
  }

  static BookingAction _mapBookingAction(String? value) {
    switch (value) {
      case 'new':
        return BookingAction.newBooking;
      case 'approve':
        return BookingAction.approved;
      case 'reject':
        return BookingAction.rejected;
      case 'update_request':
        return BookingAction.updateRequest;
      case 'update_approved':
        return BookingAction.updateApproved;
      case 'update_rejected':
        return BookingAction.updateRejected;
      default:
        return BookingAction.unknown;
    }
  }
}
