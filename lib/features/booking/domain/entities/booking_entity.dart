
class Booking {
  final String id;
  final String apartmentId;
  final DateTime startDate;
  final DateTime endDate;
  final String userId;//?
  final bool approved;//?
// final BookingStatus status; // pending, approved, cancelled

  Booking({
    required this.id,
    required this.apartmentId,
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.approved,
  // required this.status,
  });
}
//...........


