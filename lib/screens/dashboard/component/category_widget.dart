import 'dart:math' as math;
import 'package:booking_system_flutter/component/cached_image_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/category_model.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../newDashboard/dashboard_3/component/category_dashboard_component_3.dart';
import '../../newDashboard/dashboard_4/component/category_dashboard_component_4.dart';
class CategoryWidget extends StatelessWidget {
  final CategoryData categoryData;
  final double? width;
  final bool? isFromCategory;

  CategoryWidget({required this.categoryData, this.width, this.isFromCategory});

  Widget buildDefaultComponent(BuildContext context) {
    final cellWidth = width ?? context.width() / 3.2- 20;
    final iconSize = math.min(CATEGORY_ICON_SIZE, cellWidth - 8);
    return SizedBox(
      width: cellWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          categoryData.categoryImage.validate().endsWith('.svg')
              ? Container(
                  width: iconSize,
                  height: iconSize,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: context.cardColor, shape: BoxShape.circle),
                  child: SvgPicture.network(
                    categoryData.categoryImage.validate(),
                    height: iconSize,
                    width: iconSize,
                    colorFilter: ColorFilter.mode(
                      appStore.isDarkMode ? Colors.white : categoryData.color.validate(value: '000').toColor(),
                      BlendMode.srcIn,
                    ),
                    placeholderBuilder: (context) => PlaceHolderWidget(
                      height: iconSize,
                      width: iconSize,
                      color: transparentColor,
                    ),
                  ).paddingAll(10),
                )
              : Container(
                  width: iconSize,
                  height: iconSize,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: appStore.isDarkMode ? Colors.white24 : context.cardColor,
                      shape: BoxShape.circle),
                  child: CachedImageWidget(
                    url: categoryData.categoryImage.validate(),
                    fit: BoxFit.cover,
                    width: (iconSize - 28).clamp(24.0, 40.0),
                    height: (iconSize - 28).clamp(24.0, 40.0),
                    circle: true,
                    placeHolderImage: '',
                  ),
                ),
          4.height,
          SizedBox(
            width: double.infinity,
            child: Text(
              '${categoryData.name.validate()}',
              style: primaryTextStyle(size: 12),

              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget categoryComponent() {
      return Observer(builder: (context) {
        if (appConfigurationStore.userDashboardType == DASHBOARD_1) {
          return buildDefaultComponent(context);
        } else if (appConfigurationStore.userDashboardType == DASHBOARD_2) {
          return buildDefaultComponent(context);
        } else if (appConfigurationStore.userDashboardType == DASHBOARD_3) {
          return CategoryDashboardComponent3(categoryData: categoryData, width: context.width() / 4 - 20);
        } else if (appConfigurationStore.userDashboardType == DASHBOARD_4) {
          return CategoryDashboardComponent4(categoryData: categoryData);
        } else {
          return buildDefaultComponent(context);
        }
      });
    }

    return categoryComponent();
  }
}