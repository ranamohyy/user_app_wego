enum PaymentMethod {
  vodafoneCash,
  instaPay,
  paypal,
  bank,
  fromWallet,
  cashOnDelivery,
}

extension PaymentMethodX on PaymentMethod {
  String get asApiValue {
    switch (this) {
      case PaymentMethod.vodafoneCash:
        return 'vodafone_cash';
      case PaymentMethod.instaPay:
        return 'instapay';
      case PaymentMethod.paypal:
        return 'paypal';
      case PaymentMethod.bank:
        return 'bank';
      case PaymentMethod.fromWallet:
        return 'wallet';
      case PaymentMethod.cashOnDelivery:
        return 'cash';
    }
  }

  String get displayName {
    switch (this) {
      case PaymentMethod.vodafoneCash:
        return 'Vodafone Cash';
      case PaymentMethod.instaPay:
        return 'InstaPay';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.bank:
        return 'Bank';
      case PaymentMethod.fromWallet:
        return 'From Wallet';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }
}

