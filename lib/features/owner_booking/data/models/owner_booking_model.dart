import '../../../booking/data/models/payment_model.dart';
import '../../domain/entities/owner_booking_entity.dart';

class OwnerBookingModel extends OwnerBookingEntity {
  OwnerBookingModel({
    required super.id,
    required super.user_id,
    required super.apartment_id,
    required super.startDate,
    required super.endDate,
    required super.totalPrice,
    required super.status,
    required super.payment,
  });

  factory OwnerBookingModel.fromJson(Map<String, dynamic> json) {
    return OwnerBookingModel(
      id: json['id'],
      user_id: json['user_id'],
      apartment_id: json['apartment_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalPrice: json['total_price'],
      status: json['status'],
      payment: PaymentModel.fromJson(json['payment']),
    );
  }

}

