enum PaymentMethod {
  creditCard,
  wallet,
}

extension PaymentMethodX on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'credit_card';
      case PaymentMethod.wallet:
        return 'wallet';
    }
  }

  String get label {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.wallet:
        return 'Wallet';
    }
  }
}
