import 'package:booking_system_flutter/features/payment/domain/entities/payment_method.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class BankScreen extends StatelessWidget {
  const BankScreen({
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
    final String methodName = PaymentMethod.bank.displayName;
    // Placeholder bank details – replace with API or config
    const String bankName = 'Example Bank';
    const String iban = 'XX00 0000 0000 0000 0000 0000';
    const String accountName = 'Handyman Account';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.account_balance, size: 64, color: primaryColor),
            const SizedBox(height: 24),
            const Text(
              'Bank Transfer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (amount != null) ...[
              const SizedBox(height: 8),
              Text(
                'Amount: $amount',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ],
            const SizedBox(height: 32),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('Bank', bankName),
                    const Divider(),
                    _buildRow('Account name', accountName),
                    const Divider(),
                    _buildRow('IBAN', iban),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Transfer the amount to the above account. Payment will be confirmed after we receive it.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'I have transferred',
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

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
