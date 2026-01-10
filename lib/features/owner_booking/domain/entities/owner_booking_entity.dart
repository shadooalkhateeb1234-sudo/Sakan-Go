
class OwnerBookingEntity {
  final int id;
  final int user_id;
  final int apartment_id;
  final String startDate;
  final String endDate;
  final int totalPrice;
  final String status;

  OwnerBookingEntity({
    required this.id,
    required this.user_id,
    required this.apartment_id,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });
}
