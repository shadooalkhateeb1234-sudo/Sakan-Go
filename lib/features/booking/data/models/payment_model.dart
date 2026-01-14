import '../../domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.method,
    required super.status,
    required super.amount,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      method: json['method'],
      status: json['status'],
      amount: double.parse(json['amount'].toString()),
    );
  }
}