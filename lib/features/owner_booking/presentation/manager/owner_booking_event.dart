part of 'owner_booking_bloc.dart';

abstract class OwnerBookingEvent extends Equatable {
  const OwnerBookingEvent();
}
class LoadOwnerBookings extends OwnerBookingEvent{
  @override
   List<Object?> get props =>  [];

}

class ApproveBookingEvent extends OwnerBookingEvent{
  final int id;
  ApproveBookingEvent(this.id);
  @override
   List<Object?> get props =>  [id];

}
class RejectBookingEvent extends OwnerBookingEvent{
  final int id;
  RejectBookingEvent(this.id);
  @override
   List<Object?> get props =>  [id];

}

class LoadOwnerUpdateRequests extends OwnerBookingEvent {
  @override
   List<Object?> get props => [];
}

class ApproveUpdateRequestEvent extends OwnerBookingEvent {
  final int requestId;
  ApproveUpdateRequestEvent(this.requestId);

  @override
  List<Object> get props => [requestId];
}

class RejectUpdateRequestEvent extends OwnerBookingEvent {
  final int requestId;
  RejectUpdateRequestEvent(this.requestId);

  @override
  List<Object> get props => [requestId];
}
