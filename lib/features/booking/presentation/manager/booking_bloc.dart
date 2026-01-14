import 'package:sakan_go/features/booking/domain/entities/payment_entity.dart';
import '../../domain/use_cases/create_booking_usecase.dart';
import '../../domain/use_cases/cancel_booking_usecase.dart';
import '../../domain/use_cases/reject_booking_usecase.dart';
import '../../domain/use_cases/request_booking_update.dart';
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
  final UpdateBookingUseCase updateBooking;
  final RejectBookingUseCase rejectBooking;


  BookingBloc({
    required this.createBooking,
    required this.cancelBooking,
    required this.getUserBookings,
    required this.updateBooking,
    required this.rejectBooking,


  }) : super(BookingInitial()) {
    on<GetUserBookingsEvent>(_onGetBookings);
    on<CreateBookingEvent>(_onCreateBooking);
    on<CancelBookingEvent>(_onCancelBooking);
    on<UpdateBookingEvent>(_onUpdateBooking);
    on<RejectBookingEvent>(_onRejectBooking);

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
          (f) => emit(BookingError(f.message)),
          (_) {
        emit(const BookingActionSuccess('booking_request_sent'));
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
        emit(BookingActionSuccess('booking_cancelled'));
        add(GetUserBookingsEvent());
      },
    );
  }

  Future<void> _onUpdateBooking(
      UpdateBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());

    final result = await updateBooking(
      booking_id: event.booking_id,
      startDate: event.start_date,
      endDate: event.end_date,
      paymentMethod: event.paymentMethod,
    );

    result.fold(
          (f) => emit(BookingError(f.message)),
          (_) {
        emit(const BookingActionSuccess('booking_update_requested'));
        add(GetUserBookingsEvent());
      },
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
        emit(BookingActionSuccess(
          'booking_rejected',
        ));
        add(GetUserBookingsEvent());
      },
    );
  }


}
