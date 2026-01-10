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
  });

  factory OwnerBookingModel.fromJson(Map<String, dynamic> json) {
    return OwnerBookingModel(
      id: json['id'],
      user_id: json['user_id'],
      apartment_id: json['apartment_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalPrice: json['total_price'],
      status: json['status'],
    );
  }
}
