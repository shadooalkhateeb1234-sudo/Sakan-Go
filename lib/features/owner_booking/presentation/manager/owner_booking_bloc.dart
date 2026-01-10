import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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


class OwnerBookingBloc
    extends Bloc<OwnerBookingEvent, OwnerBookingState> {
  final GetOwnerBookings getBookings;
  final ApproveBooking approve;
  final RejectBooking reject;
  final GetOwnerUpdateRequests getRequests;
  final ApproveUpdateRequest approveUpdateRequest;
  final RejectUpdateRequest rejectUpdateRequest;

  OwnerBookingBloc({
    required this.getBookings,
    required this.approve,
    required this.reject,
    required this.getRequests,
    required this.approveUpdateRequest,
    required this.rejectUpdateRequest,
  }) : super(OwnerBookingInitial()) {
    on<LoadOwnerBookings>(_onLoad);
    on<ApproveBookingEvent>(_onApprove);
    on<RejectBookingEvent>(_onReject);
    on<LoadOwnerUpdateRequests>(_onLoadUpdate);
    on<ApproveUpdateRequestEvent>(_onApproveUpdate);
    on<RejectUpdateRequestEvent>(_onRejectUpate);
  }

  Future<void> _onLoad(LoadOwnerBookings event, Emitter emit) async {
    emit(OwnerBookingLoading());
    try {
      final data = await getBookings();
      emit(OwnerBookingLoaded(data));
    } catch (_) {
      emit(const OwnerBookingError('Failed to load bookings'));
    }
  }

  // Future<void> _onApprove(ApproveBookingEvent event, Emitter emit) async {
  //   await approve(event.id);
  //   add(LoadOwnerBookings());
  //   /// 🔔 Backend will send notification to USER
  //   emit(OwnerBookingActionSuccess());
  // }
  Future<void> _onApprove(
      ApproveBookingEvent event,
      Emitter emit,
      ) async {
    try {
      emit(OwnerBookingActionLoading());
      await approve(event.id);
      final data = await getBookings();
      emit(OwnerBookingLoaded(data));
    } catch (_) {
      emit(const OwnerBookingError('Action failed'));
    }
  }



  Future<void> _onReject(RejectBookingEvent event, Emitter emit) async {
    await reject(event.id);
    add(LoadOwnerBookings());
    /// 🔔 Backend will send notification to USER
    emit(OwnerBookingActionSuccess());
  }



  Future<void> _onLoadUpdate(LoadOwnerUpdateRequests event,
      Emitter emit) async {
    emit(OwnerUpdateLoading());

    try {
      final data = await getRequests();
      emit(OwnerUpdateLoaded(data));
    } catch (_) {
      emit(const OwnerUpdateError('Failed to load update requests'));
    }
  }

  Future<void> _onApproveUpdate(ApproveUpdateRequestEvent event,
      Emitter emit) async {
    await approveUpdateRequest(event.requestId);
    add(LoadOwnerUpdateRequests());
    /// 🔔 Backend will send notification to USER
    emit(OwnerBookingActionSuccess());
  }

  Future<void> _onRejectUpate(RejectUpdateRequestEvent event,
      Emitter emit) async {
    await rejectUpdateRequest(event.requestId);
    add(LoadOwnerUpdateRequests());
    /// 🔔 Backend will send notification to USER
    emit(OwnerBookingActionSuccess());
  }
}