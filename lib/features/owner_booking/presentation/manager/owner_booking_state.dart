part of 'owner_booking_bloc.dart';

abstract class OwnerBookingState extends Equatable {
  const OwnerBookingState();
}

class OwnerBookingInitial extends OwnerBookingState {
  @override
  List<Object> get props => [];
}
class OwnerBookingLoading extends OwnerBookingState {
  OwnerBookingLoading();
  @override
   List<Object?> get props => [];
}

 class OwnerBookingLoaded extends OwnerBookingState {
  final List<OwnerBookingEntity> bookings;

  const OwnerBookingLoaded(this.bookings);

  int get pendingCount =>
      bookings.where((b) => b.status == 'pending').length;
  @override
  List<Object?> get props => [bookings];
}

class OwnerBookingError extends OwnerBookingState {
  final String message;
  const OwnerBookingError(this.message);

  @override
  List<Object> get props => [message];
}
class OwnerUpdateInitial extends OwnerBookingState {
  @override

   List<Object?> get props => [];
}

class OwnerUpdateLoading extends OwnerBookingState {
  @override

  List<Object?> get props => [];
}

class OwnerUpdateLoaded extends OwnerBookingState {
  final List<BookingUpdateRequestEntity> requests;

  OwnerUpdateLoaded(this.requests);

  int get pendingCount =>
      requests.where((r) => r.status == 'pending').length;

  @override
  List<Object> get props => [requests];
}



class OwnerBookingActionSuccess extends OwnerBookingState {
  @override
  List<Object?> get props => [];
}

class OwnerUpdateError extends OwnerBookingState {
  final String message;
  const OwnerUpdateError(this.message);

  @override
  List<Object> get props => [message];
}
class OwnerBookingActionLoading extends OwnerBookingState {
  @override

  List<Object?> get props =>  [];
}

class OwnerBookingCounters extends OwnerBookingState {
  final int bookingsCount;
  final int updatesCount;

  const OwnerBookingCounters({
    required this.bookingsCount,
    required this.updatesCount,
  });

  @override
  List<Object> get props => [bookingsCount, updatesCount];
}
