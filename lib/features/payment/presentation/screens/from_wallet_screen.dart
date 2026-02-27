import 'package:booking_system_flutter/features/payment/domain/entities/payment_method.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class FromWalletScreen extends StatelessWidget {
  const FromWalletScreen({
    super.key,
    this.itemId,
    this.itemTitle,
    this.amount,
  });

  final int? itemId;
  final String? itemTitle;
  final num? amount;

  @override
  Widget build(BuildContext context) {
    final String methodName = PaymentMethod.fromWallet.displayName;
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
            Icon(Icons.account_balance_wallet, size: 64, color: primaryColor),
            const SizedBox(height: 24),
            Text(
              'Pay from Wallet',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (amount != null)
              Text(
                'Amount: $amount',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            const SizedBox(height: 24),
            Text(
              'The amount will be deducted from your wallet balance. Ensure you have sufficient balance.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Call wallet payment API when booking context is available
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Pay from Wallet',
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
  }
}
