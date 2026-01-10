import 'package:equatable/equatable.dart';
import '../../domain/entities/booking_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class BookingInitial extends BookingState {}

/// تحميل (Skeleton / Loader)
class BookingLoading extends BookingState {}

/// قائمة الحجوزات
class BookingLoaded extends BookingState {
  final List<BookingEntity> bookings;

  const BookingLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

/// نجاح عملية (Create / Update / Cancel)
class BookingActionSuccess extends BookingState {
  final String message;

  const BookingActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// خطأ
class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingConflict extends BookingState {
  final bool hasConflict;
  BookingConflict(this.hasConflict);

  @override
   List<Object?> get props => [hasConflict];
}

class BookingNotFound extends BookingState {
  final String message;
  const BookingNotFound(this.message);
}
class BookingEmpty extends BookingState {
  final String message;
  const BookingEmpty(this.message);
}
//......



