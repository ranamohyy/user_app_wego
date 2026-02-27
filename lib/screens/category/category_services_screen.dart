import 'package:booking_system_flutter/screens/service/view_all_service_screen.dart';
import 'package:flutter/material.dart';

class CategoryServicesScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const CategoryServicesScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return ViewAllServiceScreen(
      categoryId: categoryId,
      categoryName: categoryName,
      isFromCategory: true,
    );
  }
}

