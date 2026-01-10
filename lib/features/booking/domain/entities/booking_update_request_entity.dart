
class BookingUpdateRequestEntity {
  final int id;
  final int booking_id;
  final String status;
  final DateTime update_start_date;
  final DateTime update_end_date;
 // final String paymentMethod,
  BookingUpdateRequestEntity({
    required this.id,
    required this.booking_id,
    required this.status,
    required this.update_start_date,
    required this.update_end_date,
    //required this.paymentMethod,
  });
}
