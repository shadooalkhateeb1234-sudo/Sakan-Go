class PaymentEntity {
  final String method;
  final String status;
  final double amount;

  const PaymentEntity({
    required this.method,
    required this.status,
    required this.amount,
  });
}