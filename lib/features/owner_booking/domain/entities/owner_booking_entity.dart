import '../../../booking/domain/entities/payment_entity.dart';

class OwnerBookingEntity {
  final int id;
  final int user_id;
  final int apartment_id;
  final DateTime startDate;
  final DateTime endDate;
  final int totalPrice;
  final String status;
  final PaymentEntity payment;

  OwnerBookingEntity({
    required this.id,
    required this.user_id,
    required this.apartment_id,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    required this.payment,
  });
}
