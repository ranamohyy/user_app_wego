import 'package:booking_system_flutter/screens/find_driver/models/driver_model.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DriverCard extends StatelessWidget {
  final DriverData driver;
  final VoidCallback onSelect;

  const DriverCard({
    super.key,
    required this.driver,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: primaryColor.withOpacity(0.1),
            child: Icon(Icons.person, color: primaryColor),
          ),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(driver.name ?? 'Driver', style: boldTextStyle()),
                4.height,
                Text(
                  '${driver.distance?.toStringAsFixed(1) ?? 0} km away',
                  style: secondaryTextStyle(size: 12),
                ),
              ],
            ),
          ),
          AppButton(
            text: 'Select',
            color: primaryColor,
            textColor: Colors.white,
            height: 36,
            onTap: onSelect,
          ),
        ],
      ),
    );
  }
}
