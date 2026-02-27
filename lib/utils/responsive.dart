import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';

/// Scale factor from design width (360).
double scaleW(BuildContext context) =>
    MediaQuery.sizeOf(context).width / DESIGN_WIDTH;

/// Scale factor from design height (800).
double scaleH(BuildContext context) =>
    MediaQuery.sizeOf(context).height / DESIGN_HEIGHT;

/// Responsive horizontal/width-based size (font, icon, padding).
double rs(BuildContext context, double size) => size * scaleW(context);

/// Responsive vertical/height-based size (spacing, heights).
double rh(BuildContext context, double size) => size * scaleH(context);
