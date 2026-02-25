import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/screens/find_driver/screens/find_driver_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FindDriverButton extends StatelessWidget {
  final BookingDetailResponse bookingDetail;

  const FindDriverButton({
    Key? key,
    required this.bookingDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: AppButton(
          text: language.findDriver,
          textColor: Colors.white,
          color: primaryColor,
          width: context.width(),
          height: 50,
          onTap: () {
            final booking = bookingDetail.bookingDetail;
            if (booking == null) {
              toast(language.somethingWentWrong);
              return;
            }

            // Booking address is string only - pass null for lat/lng so FindDriverScreen uses current location
            FindDriverScreen(
              // bookingDetail: bookingDetail,
              // pickupLatitude: null,
              // pickupLongitude: null,
              // dropLatitude: null,
              // dropLongitude: null,
              // pickupAddress: booking.address ?? '',
              // dropAddress: booking.address ?? '',
            ).launch(context);
          },
        ),
      ),
    );
  }
}
