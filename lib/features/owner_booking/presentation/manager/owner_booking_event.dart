part of 'owner_booking_bloc.dart';


abstract class OwnerBookingEvent extends Equatable {
  const OwnerBookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadOwnerBookings extends OwnerBookingEvent {}

class ApproveBookingEvent extends OwnerBookingEvent {
  final int bookingId;

  const ApproveBookingEvent(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class RejectBookingEvent extends OwnerBookingEvent {
  final int bookingId;

  const RejectBookingEvent(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class LoadOwnerUpdateRequests extends OwnerBookingEvent {}

class ApproveUpdateRequestEvent extends OwnerBookingEvent {
  final int requestId;
  final int bookingId;

  const ApproveUpdateRequestEvent({
    required this.requestId,
    required this.bookingId,
  });

  @override
  List<Object?> get props => [requestId, bookingId];
}

class RejectUpdateRequestEvent extends OwnerBookingEvent {
  final int requestId;
  final int bookingId;

  const RejectUpdateRequestEvent({
    required this.requestId,
    required this.bookingId,
  });

  @override
  List<Object?> get props => [requestId, bookingId];
}
