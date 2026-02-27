import 'package:booking_system_flutter/features/payment/domain/entities/payment_method.dart';
import 'package:booking_system_flutter/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:booking_system_flutter/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:booking_system_flutter/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:booking_system_flutter/features/payment/presentation/screens/bank_screen.dart';
import 'package:booking_system_flutter/features/payment/presentation/screens/from_wallet_screen.dart';
import 'package:booking_system_flutter/features/payment/presentation/screens/paypal_screen.dart';
import 'package:booking_system_flutter/features/payment/presentation/screens/transfer_screen.dart';
import 'package:booking_system_flutter/screens/find_driver/screens/find_driver_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodScreen extends StatefulWidget {
  /// Optional context about what the user is paying for.
  final int? itemId;
  final String? itemTitle;
  final num? amount;

  const PaymentMethodScreen({
    super.key,
    this.itemId,
    this.itemTitle,
    this.amount,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _cashOnDeliverySelected = false;

  void _navigateToTransfer(PaymentMethod method) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => PaymentCubit(
            PaymentRepositoryImpl(PaymentRemoteDataSource()),
          ),
          child: TransferScreen(paymentMethod: method),
        ),
      ),
    );
  }

  void _navigateToPayPal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PayPalScreen(
          itemId: widget.itemId,
          itemTitle: widget.itemTitle,
          amount: widget.amount,
        ),
      ),
    );
  }

  void _navigateToBank() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BankScreen(
          itemId: widget.itemId,
          itemTitle: widget.itemTitle,
          amount: widget.amount,
        ),
      ),
    );
  }

  void _navigateToFromWallet() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FromWalletScreen(
          itemId: widget.itemId,
          itemTitle: widget.itemTitle,
          amount: widget.amount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.itemTitle != null || widget.amount != null) ...[
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.itemTitle != null)
                      Text(
                        widget.itemTitle!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    if (widget.amount != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Amount: ${widget.amount}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _MethodTile(
            title: PaymentMethod.vodafoneCash.displayName,
            subtitle: 'Pay using Vodafone Cash wallet',
            icon: Icons.phone_iphone,
            onTap: () => _navigateToTransfer(PaymentMethod.vodafoneCash),
          ),
          const SizedBox(height: 12),
          _MethodTile(
            title: PaymentMethod.instaPay.displayName,
            subtitle: 'Pay using InstaPay',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => _navigateToTransfer(PaymentMethod.instaPay),
          ),
          const SizedBox(height: 12),
          _MethodTile(
            title: PaymentMethod.paypal.displayName,
            subtitle: 'Pay with PayPal',
            icon: Icons.payment,
            onTap: _navigateToPayPal,
          ),
          const SizedBox(height: 12),
          _MethodTile(
            title: PaymentMethod.bank.displayName,
            subtitle: 'Pay via bank transfer',
            icon: Icons.account_balance,
            onTap: _navigateToBank,
          ),
          const SizedBox(height: 12),
          _MethodTile(
            title: PaymentMethod.fromWallet.displayName,
            subtitle: 'Pay from your wallet balance',
            icon: Icons.account_balance_wallet,
            onTap: _navigateToFromWallet,
          ),
          const SizedBox(height: 12),
          _CashOnDeliveryTile(
            selected: _cashOnDeliverySelected,
            onChanged: (value) => setState(() => _cashOnDeliverySelected = value ?? false),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FindDriverScreen(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Need Driver?',
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor.withValues(alpha: 0.1),
              child: Icon(icon, color: primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _CashOnDeliveryTile extends StatelessWidget {
  const _CashOnDeliveryTile({
    required this.selected,
    required this.onChanged,
  });

  final bool selected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!selected),
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: selected,
                onChanged: onChanged,
                activeColor: primaryColor,
                shape: const CircleBorder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PaymentMethod.cashOnDelivery.displayName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pay when you receive',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

