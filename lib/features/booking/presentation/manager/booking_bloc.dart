import '../../domain/use_cases/create_booking_usecase.dart';
import '../../domain/use_cases/cancel_booking_usecase.dart';
import '../../domain/use_cases/reject_booking_usecase.dart';
import '../../domain/use_cases/request_booking_update.dart';
import '../../domain/use_cases/update_booking_usecase.dart';
import '../../domain/use_cases/get_bookings_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import 'dart:async';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUseCase createBooking;
  final CancelBookingUseCase cancelBooking;
  final GetUserBookingsUsecase getUserBookings;
  //final UpdateBookingUseCase updateBooking;
  final RejectBookingUseCase rejectBooking;
  final RequestBookingUpdateUseCase requestBookingUpdate;

  BookingBloc({
    required this.createBooking,
    required this.cancelBooking,
    required this.getUserBookings,
   // required this.updateBooking,
    required this.rejectBooking,
    required this.requestBookingUpdate,

  }) : super(BookingInitial()) {
    on<GetUserBookingsEvent>(_onGetBookings);
    on<CreateBookingEvent>(_onCreateBooking);
    on<CancelBookingEvent>(_onCancelBooking);
   // on<UpdateBookingEvent>(_onUpdateBooking);
    on<RejectBookingEvent>(_onRejectBooking);
    on<RequestBookingUpdateEvent>(_onRequestBookingUpdate);
  }

  Future<void> _onGetBookings(
      GetUserBookingsEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final result = await getUserBookings();

    result.fold(
          (failure) => emit(
        BookingError(failure.message),
      ),
          (bookings) => emit(
        BookingLoaded(bookings),
      ),
    );
  }

  Future<void> _onCreateBooking(
      CreateBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final result = await createBooking(
      apartment_id: event.apartment_id,
      start_date: event.start_date,
      end_date: event.end_date,
      latitude: event.latitude,
      longitude: event.longitude,
      paymentMethod: event.paymentMethod,
    );

    result.fold(
          (failure) => emit(
        BookingError(failure.message),
      ),
          (_) {
        emit(const BookingActionSuccess(
          'the booking request has been submitted\n and is awaiting approval',
        ));
        add(GetUserBookingsEvent());
      },
    );
  }

  Future<void> _onCancelBooking(
      CancelBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final result = await cancelBooking(event.booking_id);

    result.fold(
          (failure) => emit(
        BookingError(failure.message),
      ),
          (_) {
        emit(const BookingActionSuccess('the booking has been cancelled'));
        add(GetUserBookingsEvent());
      },
    );
  }

  // Future<void> _onUpdateBooking(
  //     UpdateBookingEvent event,
  //     Emitter<BookingState> emit,
  //     ) async {
  //   emit(BookingLoading());
  //
  //   final result = await updateBooking(
  //     booking_id: event.booking_id,
  //     newStart: event.start_date,
  //     newEnd: event.end_date,
  //     paymentMethod: event.paymentMethod,
  //   );
  //
  //   result.fold(
  //         (failure) => emit(
  //       BookingError(failure.message),
  //     ),
  //         (_) {
  //       emit(const BookingActionSuccess('edit the booking'));
  //       add(GetUserBookingsEvent());
  //     },
  //   );
  //
  // }

  Future<void> _onRequestBookingUpdate(
      RequestBookingUpdateEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final result = await requestBookingUpdate (
      booking_id: event.booking_id,
      startDate: event.startDate,
      endDate: event.endDate,
      paymentMethod: event.paymentMethod,
    );

    result.fold(
          (failure) => emit(
        BookingError(failure.message),
      ),
          (_) {
        emit(const BookingActionSuccess('Update request sent, waiting for owner approval',));
        add(GetUserBookingsEvent());
      } ,

    );

  }


  Future<void> _onRejectBooking(
      RejectBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final result = await rejectBooking(event.booking_id);

    result.fold(
          (failure) => emit(BookingError(failure.message)),
          (_) {
        emit(const BookingActionSuccess(
          'The owner rejected this booking',
        ));
        add(GetUserBookingsEvent());
      },
    );
  }

}
//....................
 /*
 if (event is UpdateBookingEvent) {
  final booking = _cachedBookings.firstWhere(
    (b) => b.id == event.booking_id,
  );

  if (!BookingRules.canEdit(booking.status)) {
    emit(const BookingError('This booking cannot be edited'));
    return;
  }
}
*/