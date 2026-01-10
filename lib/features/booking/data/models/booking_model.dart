import '../../domain/entities/booking_entity.dart';


class BookingModel extends BookingEntity {
  BookingModel({
    required super.id,
    required super.apartment_id,
    required super.user_id,
    required super.start_date,
    required super.end_date,
    required super.total_price,
    required super.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      apartment_id: json['apartment_id'],
      user_id: json['user_id'],
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
      total_price: json['total_price'] ?? 0,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': start_date.toIso8601String().split('T').first,
      'end_date': end_date.toIso8601String().split('T').first,
    };
  }

  BookingModel copyWith({
    int? id,
    int? apartment_id,
    int? user_id,
    DateTime? start_date,
    DateTime? end_date,
    String? status,
    int? total_price,
  }) {
    return BookingModel(
      id: id ?? this.id,
      apartment_id: apartment_id ?? this.apartment_id,
      user_id: user_id ?? this.user_id,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      status: status ?? this.status,
      total_price: total_price ?? this.total_price,
    );
  }
}
