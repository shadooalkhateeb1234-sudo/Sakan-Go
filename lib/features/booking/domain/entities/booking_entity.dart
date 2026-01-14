
import 'package:sakan_go/features/booking/domain/entities/payment_entity.dart';

class BookingEntity {
  final int id;
  final int apartment_id;
  final int user_id;
  final DateTime start_date;
  final DateTime end_date;
  final int total_price;
  final String status;
  final PaymentEntity payment;

  const BookingEntity({
    required this.id,
    required this.apartment_id,
    required this.user_id,
    required this.start_date,
    required this.end_date,
    required this.total_price,
    required this.status,
    required this.payment,
  });
}