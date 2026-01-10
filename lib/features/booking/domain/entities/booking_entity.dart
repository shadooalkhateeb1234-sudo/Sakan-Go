
class BookingEntity {
  final int id;
  final int apartment_id;
  final int user_id;
  final DateTime start_date;
  final DateTime end_date;
  final String status; // pending | confirmed | cancelled | rejected | completed
  final int total_price;

  const BookingEntity({
    required this.id,
    required this.apartment_id,
    required this.user_id,
    required this.start_date,
    required this.end_date,
    required this.status,
    required this.total_price
  });
}
