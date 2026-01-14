part of 'owner_booking_bloc.dart';


abstract class OwnerBookingState extends Equatable {
  const OwnerBookingState();

  @override
  List<Object?> get props => [];
}

class OwnerBookingInitial extends OwnerBookingState {}

class OwnerBookingLoading extends OwnerBookingState {}

class OwnerBookingActionLoading extends OwnerBookingState {}

class OwnerBookingLoaded extends OwnerBookingState {
  final List<OwnerBookingEntity> bookings;

  const OwnerBookingLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class OwnerUpdateLoading extends OwnerBookingState {}

class OwnerUpdateLoaded extends OwnerBookingState {
  final List<BookingUpdateRequestEntity> requests;

  const OwnerUpdateLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

class OwnerBookingCounters extends OwnerBookingState {
  final int bookingsCount;
  final int updatesCount;

  const OwnerBookingCounters({
    required this.bookingsCount,
    required this.updatesCount,
  });

  @override
  List<Object?> get props => [bookingsCount, updatesCount];
}

class OwnerBookingError extends OwnerBookingState {
  final String message;

  const OwnerBookingError(this.message);

  @override
  List<Object?> get props => [message];
}

class OwnerUpdateError extends OwnerBookingState {
  final String message;

  const OwnerUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}
