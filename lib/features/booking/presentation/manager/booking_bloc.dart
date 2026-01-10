import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial());

  @override
  Stream<BookingState> mapEventToState(
    BookingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
