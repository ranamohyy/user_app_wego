import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._repository) : super(const PaymentInitial());

  final PaymentRepository _repository;

  Future<void> uploadPayment({
    required PaymentMethod method,
    required XFile screenshot,
  }) async {
    emit(const PaymentLoading());
    try {
      await _repository.uploadWalletPayment(
        method: method,
        screenshot: screenshot,
      );
      emit(const PaymentSuccess(message: 'Payment uploaded successfully.'));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}

