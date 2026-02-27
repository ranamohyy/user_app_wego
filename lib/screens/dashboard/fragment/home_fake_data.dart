import 'package:booking_system_flutter/model/category_model.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/utils/images.dart';

/// Demo data to show the redesigned home when API returns empty. Remove or disable when backend has data.
List<CategoryData> getFakeCategories() {
  const placeholders = [
    ('Cleaning', '#4CAF50'),
    ('Plumbing', '#2196F3'),
    ('Electrical', '#FF9800'),
    ('Painting', '#9C27B0'),
    ('AC Repair', '#00BCD4'),
    ('Carpentry', '#795548'),
  ];
  return List.generate(placeholders.length, (i) {
    final (name, color) = placeholders[i];
    return CategoryData(
      id: i + 1,
      name: name,
      color: color,
      // Use local assets so fake categories work without internet.
      categoryImage: switch (i % 4) {
        0 => walk_Img1,
        1 => walk_Img2,
        2 => walk_Img3,
        _ => walk_Img4,
      },
      status: 1,
      isFeatured: 1,
    );
  });
}

List<ServiceData> getFakeServices() {
  final categories = getFakeCategories();
  final names = [
    'Home Deep Cleaning',
    'Office Cleaning',
    'Pipe Repair',
    'Tap Installation',
    'Wiring Fix',
    'Switch Replacement',
    'Wall Painting',
    'Exterior Paint',
    'AC Service',
    'Gas Refill',
    'Furniture Repair',
    'Custom Cabinet',
  ];
  return List.generate(names.length, (i) {
    final catIndex = i % categories.length;
    return ServiceData(
      id: i + 100,
      name: names[i],
      categoryId: categories[catIndex].id,
      categoryName: categories[catIndex].name,
      price: 25.0 + (i * 15),
      discount: i.isEven ? 10 : 0,
      // Local placeholder images for services.
      serviceAttachments: [
        switch (i % 4) {
          0 => walk_Img1,
          1 => walk_Img2,
          2 => walk_Img3,
          _ => walk_Img4,
        }
      ],
      duration: '1 hr',
      description: 'Professional service',
    );
  });
}

List<dynamic> getFakeBanners() {
  return [
    SliderModel(
      id: 1,
      // Local splash assets for hero banner.
      sliderImage: splash_background,
      title: 'Offers',
    ),
    SliderModel(
      id: 2,
      sliderImage: splash_light_background,
      title: 'Summer Sale',
    ),
  ];
}
