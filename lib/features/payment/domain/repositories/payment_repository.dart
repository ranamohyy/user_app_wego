import 'package:image_picker/image_picker.dart';

import '../entities/payment_method.dart';

abstract class PaymentRepository {
  Future<void> uploadWalletPayment({
    required PaymentMethod method,
    required XFile screenshot,
  });
}

