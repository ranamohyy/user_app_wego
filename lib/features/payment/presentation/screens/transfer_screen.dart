import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:booking_system_flutter/features/payment/domain/entities/payment_method.dart';
import 'package:booking_system_flutter/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:booking_system_flutter/features/payment/presentation/cubit/payment_state.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key, required this.paymentMethod});

  final PaymentMethod paymentMethod;

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _onSendScreenshot() async {
    final XFile? file =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (file == null) return;

    context.read<PaymentCubit>().uploadPayment(
          method: widget.paymentMethod,
          screenshot: file,
        );
  }

  @override
  Widget build(BuildContext context) {
    final String methodName = widget.paymentMethod.displayName;
    const String walletNumber = '01012345678'; // hardcoded for now

    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          AnimatedSnackBar.material(
            state.message ?? 'Payment uploaded successfully.',
            type: AnimatedSnackBarType.success,
          ).show(context);
          Navigator.of(context).pop();
        } else if (state is PaymentError) {
          AnimatedSnackBar.material(
            state.message,
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is PaymentLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text('Pay with $methodName'),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Transfer to this Number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SelectableText(
                  walletNumber,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'After transferring, please upload a screenshot as proof.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSendScreenshot,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send Screenshot',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

