 import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserBookingsEvent extends BookingEvent {}

class CancelBookingEvent extends BookingEvent {
  final int booking_id;
  CancelBookingEvent(this.booking_id);
}

class UpdateBookingEvent extends BookingEvent {
   final int booking_id;
   final DateTime start_date;
   final DateTime end_date;
   final String paymentMethod;
     UpdateBookingEvent({
     required this.booking_id,
     required this.start_date,
     required this.end_date,
     required this.paymentMethod,
   });

   @override
   List<Object?> get props => [booking_id, start_date, end_date, paymentMethod];
 }

 class RejectBookingEvent extends BookingEvent {
   final int booking_id;
   RejectBookingEvent(this.booking_id);

   @override
   List<Object?> get props => [booking_id];
 }

 class RequestBookingUpdateEvent extends BookingEvent {
   final int booking_id;
   final DateTime startDate;
   final DateTime endDate;
   final String paymentMethod;
   RequestBookingUpdateEvent({
     required this.booking_id,
     required this.startDate,
     required this.endDate,
     required this.paymentMethod,
   });
 }

 class CreateBookingEvent extends BookingEvent {
   final int apartment_id;
   final DateTime start_date;
   final DateTime end_date;
   final double latitude;
   final double longitude;
   final String paymentMethod;

   CreateBookingEvent({
     required this.apartment_id,
     required this.start_date,
     required this.end_date,
     required this.latitude,
     required this.longitude,
     required this.paymentMethod,
   });
 }
