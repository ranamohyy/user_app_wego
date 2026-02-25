import 'package:booking_system_flutter/features/payment/domain/entities/payment_method.dart';
import 'package:booking_system_flutter/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:booking_system_flutter/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:booking_system_flutter/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:booking_system_flutter/features/payment/presentation/screens/transfer_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  void _navigateToTransfer(
    BuildContext context,
    PaymentMethod method,
  ) {
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
          _MethodTile(
            title: PaymentMethod.vodafoneCash.displayName,
            subtitle: 'Pay using Vodafone Cash wallet',
            icon: Icons.phone_iphone,
            onTap: () => _navigateToTransfer(context, PaymentMethod.vodafoneCash),
          ),
          const SizedBox(height: 12),
          _MethodTile(
            title: PaymentMethod.instaPay.displayName,
            subtitle: 'Pay using InstaPay',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => _navigateToTransfer(context, PaymentMethod.instaPay),
          ),
        ],
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

