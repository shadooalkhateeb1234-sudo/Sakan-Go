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

  /// localization key
  String get labelKey {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'credit_card';
      case PaymentMethod.wallet:
        return 'wallet';
    }
  }
}
