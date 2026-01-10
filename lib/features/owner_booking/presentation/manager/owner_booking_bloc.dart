import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owner_booking_event.dart';
part 'owner_booking_state.dart';

class OwnerBookingBloc extends Bloc<OwnerBookingEvent, OwnerBookingState> {
  OwnerBookingBloc() : super(OwnerBookingInitial());

  @override
  Stream<OwnerBookingState> mapEventToState(
    OwnerBookingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
