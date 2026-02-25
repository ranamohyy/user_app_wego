import 'package:image_picker/image_picker.dart';

import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl(this._remote);

  final PaymentRemoteDataSource _remote;

  @override
  Future<void> uploadWalletPayment({
    required PaymentMethod method,
    required XFile screenshot,
  }) async {
    await _remote.uploadWalletPayment(
      method: method,
      screenshot: screenshot,
    );
  }
}

