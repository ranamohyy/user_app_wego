import 'dart:io';

import 'package:booking_system_flutter/utils/configs.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../../domain/entities/payment_method.dart';

class PaymentRemoteDataSource {
  PaymentRemoteDataSource({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: BASE_URL,
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
              ),
            );

  final Dio _dio;

  Future<void> uploadWalletPayment({
    required PaymentMethod method,
    required XFile screenshot,
  }) async {
    final file = File(screenshot.path);

    final formData = FormData.fromMap({
      'payment_method': method.asApiValue,
      'screenshot': await MultipartFile.fromFile(
        file.path,
        filename: p.basename(file.path),
      ),
    });

    final response = await _dio.post(
      '/wallet/payment',
      data: formData,
    );

    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      final msg = _extractMessage(response.data) ?? 'Payment failed';
      throw PaymentRemoteException(msg);
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data['message'] is String) return data['message'] as String;
      if (data['error'] is String) return data['error'] as String;
    }
    return null;
  }
}

class PaymentRemoteException implements Exception {
  PaymentRemoteException(this.message);

  final String message;

  @override
  String toString() => message;
}

