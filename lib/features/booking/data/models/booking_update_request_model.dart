import 'package:sakan_go/features/booking/data/models/payment_model.dart';

import '../../domain/entities/booking_update_request_entity.dart';


class BookingUpdateRequestModel extends BookingUpdateRequestEntity {
  BookingUpdateRequestModel({
    required super.id,
    required super.booking_id,
    required super.status,
    required super.update_start_date,
    required super.update_end_date,
      required super.payment,
  });

  factory BookingUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingUpdateRequestModel(
      id: json['id'],
      booking_id: json['booking_id'],
      status: json['status'],
      update_start_date: DateTime.parse(json['update_start_date']),
      update_end_date: DateTime.parse(json['update_end_date']),
      payment: PaymentModel.fromJson(json['payment']),
    );
  }

  BookingUpdateRequestModel copyWith({String? status}) {
    return BookingUpdateRequestModel(
      id: id,
      booking_id: booking_id,
      status: status ?? this.status,
      update_start_date: update_start_date,
      update_end_date: update_end_date,
      payment: payment,
    );
  }
}
