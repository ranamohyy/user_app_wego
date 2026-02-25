import 'package:booking_system_flutter/component/spin_kit_chasing_dots.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: primaryColor,
    );
  }
}