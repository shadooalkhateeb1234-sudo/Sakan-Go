import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/notifications/firebase_notification_service.dart';
import '../../../../core/notifications/notification_payload.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../../domain/entities/owner_booking_entity.dart';
import '../../domain/use_cases/get_owner_update_requests.dart';
import '../../domain/use_cases/owner_approve_booking.dart';
import '../../domain/use_cases/owner_approve_update_request.dart';
import '../../domain/use_cases/owner_bookings_usecase.dart';
import '../../domain/use_cases/owner_reject_booking.dart';
import '../../domain/use_cases/owner_reject_update_request.dart';

part 'owner_booking_event.dart';
part 'owner_booking_state.dart';

class OwnerBookingBloc extends Bloc<OwnerBookingEvent, OwnerBookingState> {
  final GetOwnerBookings getBookings;
  final ApproveBooking approveBooking;
  final RejectBooking rejectBooking;
  final GetOwnerUpdateRequests getUpdateRequests;
  final ApproveUpdateRequest approveUpdateRequest;
  final RejectUpdateRequest rejectUpdateRequest;

  int _bookingsCount = 0;
  int _updatesCount = 0;

  OwnerBookingBloc({
    required this.getBookings,
    required this.approveBooking,
    required this.rejectBooking,
    required this.getUpdateRequests,
    required this.approveUpdateRequest,
    required this.rejectUpdateRequest,
  }) : super(OwnerBookingInitial()) {
    on<LoadOwnerBookings>(_loadBookings);
    on<ApproveBookingEvent>(_approveBooking);
    on<RejectBookingEvent>(_rejectBooking);
    on<LoadOwnerUpdateRequests>(_loadUpdateRequests);
    on<ApproveUpdateRequestEvent>(_approveUpdateRequest);
    on<RejectUpdateRequestEvent>(_rejectUpdateRequest);
  }

  /* ---------------- BOOKINGS ---------------- */

  Future<void> _loadBookings(
      LoadOwnerBookings event,
      Emitter<OwnerBookingState> emit,
      ) async {
    emit(OwnerBookingLoading());

    final result = await getBookings();

    result.fold(
          (failure) => emit(OwnerBookingError(_mapFailureToMessage(failure))),
          (bookings) {
        _bookingsCount = bookings.length;

        emit(OwnerBookingLoaded(bookings));
        emit(
          OwnerBookingCounters(
            bookingsCount: _bookingsCount,
            updatesCount: _updatesCount,
          ),
        );
      },
    );
  }

  Future<void> _approveBooking(
      ApproveBookingEvent event,
      Emitter<OwnerBookingState> emit,
      ) async {
    emit(OwnerBookingActionLoading());
    final result = await approveBooking(event.bookingId);

    result.fold(
          (failure) => emit(OwnerBookingError(_mapFailureToMessage(failure))),
          (_) {
        FirebaseNotificationService.instance.sendToTenant(
          bookingId: event.bookingId,
          action: BookingAction.approved,
        );
        add(LoadOwnerBookings());
      },
    );

  }

  Future<void> _rejectBooking(
      RejectBookingEvent event,
      Emitter<OwnerBookingState> emit,
      ) async {
    emit(OwnerBookingActionLoading());

    final result = await rejectBooking(event.bookingId);

    result.fold(
          (failure) => emit(OwnerBookingError(_mapFailureToMessage(failure))),
          (_) {
        FirebaseNotificationService.instance.sendToTenant(
          bookingId: event.bookingId,
          action: BookingAction.rejected,
        );
        add(LoadOwnerBookings());
      },
    );
  }

  /* ---------------- UPDATE REQUESTS ---------------- */

  Future<void> _loadUpdateRequests(
      LoadOwnerUpdateRequests event,
      Emitter<OwnerBookingState> emit,
      ) async {
    emit(OwnerUpdateLoading());

    final result = await getUpdateRequests();

    result.fold(
          (failure) =>
          emit(OwnerUpdateError(_mapFailureToMessage(failure))),
          (requests) {
        _updatesCount = requests.length;

        emit(OwnerUpdateLoaded(requests));
        emit(
          OwnerBookingCounters(
            bookingsCount: _bookingsCount,
            updatesCount: _updatesCount,
          ),
        );
      },
    );
  }

  Future<void> _approveUpdateRequest(
      ApproveUpdateRequestEvent event,
      Emitter<OwnerBookingState> emit,
      ) async {
    emit(OwnerBookingActionLoading());

    final result = await approveUpdateRequest(event.requestId);

    result.fold(
            (failure) => emit(OwnerUpdateError(_mapFailureToMessage(failure))),
      (_){
    FirebaseNotificationService.instance.sendToTenant(
      bookingId: event.bookingId,
      action: BookingAction.updateApproved,
    );
    add(LoadOwnerUpdateRequests());
      } );
  }

  Future<void> _rejectUpdateRequest(
      RejectUpdateRequestEvent event,
      Emitter<OwnerBookingState> emit,
      ) async {
    emit(OwnerBookingActionLoading());

    final result = await rejectUpdateRequest(event.requestId);
    result.fold(
            (failure) => emit(OwnerUpdateError(_mapFailureToMessage(failure))),
            (_){
    FirebaseNotificationService.instance.sendToTenant(
      bookingId: event.bookingId,
      action: BookingAction.updateRejected,
    );
      add(LoadOwnerUpdateRequests());
     } );
  }

  /* ---------------- FAILURE MAPPER ---------------- */

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'error_no_internet';
      case UnAuthorizedFailure:
        return 'error_session_expired';
      case ForbiddenFailure:
        return 'error_not_allowed';
      case NotFoundFailure:
        return 'error_not_found';
      case ConflictFailure:
        return 'error_conflict';
      case UnprocessableEntityFailure:
        return 'error_invalid_data';
      case ServerFailure:
        return 'error_server';
      default:
        return 'unexpected_error';
    }
  }
}
