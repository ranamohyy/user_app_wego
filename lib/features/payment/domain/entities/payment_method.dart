enum PaymentMethod {
  vodafoneCash,
  instaPay,
}

extension PaymentMethodX on PaymentMethod {
  String get asApiValue {
    switch (this) {
      case PaymentMethod.vodafoneCash:
        return 'vodafone_cash';
      case PaymentMethod.instaPay:
        return 'instapay';
    }
  }

  String get displayName {
    switch (this) {
      case PaymentMethod.vodafoneCash:
        return 'Vodafone Cash';
      case PaymentMethod.instaPay:
        return 'InstaPay';
    }
  }
}

