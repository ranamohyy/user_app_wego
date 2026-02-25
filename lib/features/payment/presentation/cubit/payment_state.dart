import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class PaymentError extends PaymentState {
  const PaymentError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

