import 'package:booking_system_flutter/component/cached_image_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/category_model.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/screens/notification/notification_screen.dart';
import 'package:booking_system_flutter/screens/service/search_service_screen.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/screens/service/view_all_service_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

const String kHomeFontFamily = 'Inter';

final color = appStore.isDarkMode ? Colors.white : primaryColor;
final secondcolor = appStore.isDarkMode ? Colors.white : Colors.black;
// ─────────────────────────────────────────────
// App Bar / Categories
// ─────────────────────────────────────────────

Widget homeAppBar(BuildContext context, {List<ServiceData>? featuredList}) =>
    const SizedBox.shrink();
Widget _homeSearchOverlay(BuildContext context,
    {List<ServiceData>? featuredList}) {
  return Positioned(
    top: context.statusBarHeight + rs(context, 12),
    left: rs(context, 16),
    right: rs(context, 16),
    child: Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.black.withOpacity(0.55),
            borderRadius: BorderRadius.circular(rs(context, 30)),
            child: InkWell(
              onTap: () =>
                  SearchServiceScreen(featuredList: featuredList).launch(context),
              borderRadius: BorderRadius.circular(rs(context, 30)),
              child: SizedBox(
                height: rh(context, 48),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded,
                        size: rs(context, 20), color: Colors.white70),
                    SizedBox(width: rs(context, 10)),
                    Text(
                      'Find places and things to do',
                      style: secondaryTextStyle(
                          size: (rs(context, LABEL_TEXT_SIZE.toDouble())).round(),
                          color: Colors.white70,
                          fontFamily: kHomeFontFamily),
                    ),
                  ],
                ).paddingSymmetric(horizontal: rs(context, 16)),
              ),
            ),
          ),
        ),
        SizedBox(width: rs(context, 12)),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: rh(context, 48),
              height: rh(context, 48),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.notifications_outlined,
                    size: rs(context, 24), color: Colors.white),
                onPressed: () => NotificationScreen().launch(context),
              ),
            ),
            if (appStore.unreadCount.validate() > 0)
              Positioned(
                top: rs(context, 4),
                right: rs(context, 4),
                child: Container(
                  padding: EdgeInsets.all(rs(context, 4)),
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    '${appStore.unreadCount > 9 ? '9+' : appStore.unreadCount}',
                    style: primaryTextStyle(
                        size: (rs(context, TEXT_SIZE_XS)).round(),
                        color: Colors.white,
                        fontFamily: kHomeFontFamily),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
String _bannerImageUrl(dynamic item) {
  if (item is SliderModel) return item.sliderImage ?? '';
  if (item is PromotionalBannerModel) return item.image ?? '';
  return '';
}
Widget homeHeroBanner(
    BuildContext context,
    List<dynamic> items,
      List<CategoryData> categories,
      int selectedCategoryIndex,
      ValueChanged<int> onCategorySelected,
    ) {
  final url = items.isNotEmpty ? _bannerImageUrl(items[0]) : '';
  final height = context.height() * 0.5;

  return SizedBox(
    height: height,
    width: double.infinity,
    child: Stack(
      children: [
        // ── Background image ──────────────────────────────────
        Positioned.fill(
          child: url.isNotEmpty
              ? CachedImageWidget(
            url: url,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            placeHolderImage: '',
          )
              : Container(
            color: const Color(0xFF1C1F26),
            child: Icon(Icons.explore_rounded,
                size: rs(context, 64), color: Colors.white24),
          ),
        ),

        // ── Gradient overlay ──────────────────────────────────
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.4, 1.0],
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.transparent,
                  Colors.black.withOpacity(0.92),
                ],
              ),
            ),
          ),
        ),

        _homeSearchOverlay(context),

        Positioned(
          left: 0,
          right: 0,
          bottom: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find your next\nservice experience',
                      style: boldTextStyle(
                          size: (rs(context, TEXT_SIZE_HERO)).round(),
                          color: Colors.white,
                          fontFamily: kHomeFontFamily),
                    ),
                    SizedBox(height: rh(context, 12)),
                    GestureDetector(
                      onTap: () =>
                          SearchServiceScreen(featuredList: null).launch(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Learn more',
                              style: secondaryTextStyle(
                                  size: (rs(context, TEXT_SIZE_SUBTITLE)).round(),
                                  color: Colors.white,
                                  fontFamily: kHomeFontFamily)),
                          SizedBox(width: rs(context, 4)),
                          Icon(Icons.chevron_right,
                              size: rs(context, 18.0),
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: rh(context, 20)),
              // if (categories != null && categories.isNotEmpty)
              //   SizedBox(
              //     height: 72,
              //     child: ListView(
              //       scrollDirection: Axis.horizontal,
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: kHomePadding),
              //       children: [
              //         // _categoryIconChip(
              //         //   context,
              //         //   label: 'rana mohy',
              //         //   icon: Icons.auto_awesome,
              //         //   selected: false,
              //         //   // selected: (selectedCategoryIndex ?? 0) == 0,
              //         //   onTap: () => onCategorySelected?.call(0),
              //         // ),
              //         ...List.generate(categories.length, (i) {
              //           final cat = categories[i];
              //           return
              //             homeCategoryChips(context,
              //                 data.categories,
              //                 selectedIndex: _selectedCategoryIndex,
              //                 onSelected: (i) => setState(() => _selectedCategoryIndex = i)),
              //
              //           );
              //         }),
              //       ],
              //     ),
              //   ),
              SizedBox(height: rh(context, 16)),
            ],
          ),
        ),

        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: homeCategoryChips(
                context,
                categories,
               selectedCategoryIndex,
              onCategorySelected,


            ))


      ],
    ),
  );
}
Widget _sectionHeader(BuildContext context, String title, {VoidCallback? onSeeAll,}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style:GoogleFonts.poppins(
              height: 0,
              // boldTextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: secondcolor,
              // fontFamily: kHomeFontFamily,
              // ),
            ),
          ),),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text('See all',
                style: secondaryTextStyle(
                    size: (rs(context, LABEL_TEXT_SIZE.toDouble())).round(),
                    color: color,
                    fontFamily: kHomeFontFamily)),
          ),
      ],
    ),
  );
}
Widget homeTopRated(BuildContext context, List<ServiceData> list) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(context, 'Top Rated'),
      SizedBox(height: rh(context, 16)),
      SizedBox(
        height: rh(context, 330),
        child: list.isEmpty
            ? homePlaceholderCard(context,
            icon: Icons.star_rounded,
            message: 'No experiences yet')
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
          itemCount: list.length,
          itemBuilder: (ctx, i) => homeActivityCard(ctx, list[i]),
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────
// CATEGORY SERVICES SECTION
// ─────────────────────────────────────────────
Widget homeCategoryChips(
    BuildContext context,
    List<CategoryData> categories,
      int selectedIndex,
      ValueChanged<int> onSelected,
    ) {
  return Container(
    height: rh(context, 85),
    color: Colors.black.withOpacity(0.75),
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: rs(context, 0)),
      children: [
        _chip(context, 'For you', true, 0 == (selectedIndex ?? 0),
                () => onSelected?.call(0)),
        SizedBox(width: rs(context, 12)),
        ...List.generate(categories.length, (i) {
          final cat = categories[i];
          final selected = selectedIndex == i + 1;
          return Padding(
            padding: EdgeInsets.only(right: rs(context, 12)),
            child: _chip(
              context,
              cat.name.validate(),
              false,
              selected,
                  () => onSelected?.call(i + 1),
            ),
          );
        }),
      ],
    ),
  );
}//
Widget _chip(
    BuildContext context,
    String label,
    bool withIcon,
    bool selected,
    VoidCallback onTap,
    ) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: rs(context, 90),
      padding: EdgeInsets.symmetric(vertical: rh(context, 0)),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white
            : Colors.transparent,
        borderRadius: BorderRadius.only(
  topRight: Radius.circular(rs(context, 14),),topLeft: Radius.circular(rs(context, 14),)

  ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (withIcon)
            Icon(
              Icons.auto_awesome,
              size: rs(context, 22),
              color: selected?primaryColor:Colors.white,
            ),
          if (withIcon) SizedBox(height: rh(context, 6)),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color:selected?primaryColor:Colors.white,
              fontSize: (rs(context, 13)).roundToDouble(),
              fontWeight:
              selected ? FontWeight.w700 : FontWeight.w500,
              fontFamily: kHomeFontFamily,
            ),
          ),
        ],
      ),
    ),
  );
}
Widget homeCategoryServicesSection(
    BuildContext context,
    String title,
    List<ServiceData> services,
    int? categoryId, {
      String? categoryName,
    }) {
  final nameForAll =
      categoryName ?? title.replaceFirst(RegExp(r'Based on your search in '), '');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(
        context,
        title,
        onSeeAll: (services.isNotEmpty && categoryId != null)
            ? () => ViewAllServiceScreen(
          categoryId: categoryId,
          categoryName: nameForAll,
          isFromCategory: true,
        ).launch(context)
            : null,
      ),
      SizedBox(height: rh(context, 16)),
      SizedBox(
        height: rh(context, 330),
        child: services.isEmpty
            ? homePlaceholderCard(context,
            icon: Icons.explore_rounded,
            message: 'No experiences available')
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
          itemCount: services.length,
          itemBuilder: (ctx, i) => homeActivityCard(ctx, services[i]),
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────
// CATEGORIES GRID
// ─────────────────────────────────────────────
Widget homeCategoriesGrid(
    BuildContext context, List<CategoryData> categories) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader(context, 'Explore Categories'),
      SizedBox(height: rh(context, 16)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: rh(context, 12),
            crossAxisSpacing: rs(context, 12),
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              homeCategoryCard(context, categories[index]),
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────
// CATEGORY CARD  (grid item)
// ─────────────────────────────────────────────
Widget homeCategoryCard(BuildContext context, CategoryData cat) {
  Color bgColor = context.cardColor;
  try {
    final v = cat.color.validate(value: 'E8E8E8');
    bgColor = (v.startsWith('#') ? v : '#$v')
        .toColor()
        .withOpacity(0.25);
  } catch (_) {}
  return GestureDetector(
    onTap: () => ViewAllServiceScreen(
      categoryId: cat.id,
      categoryName: cat.name,
      isFromCategory: true,
    ).launch(context),
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(rs(context, 16)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (cat.categoryImage.validate().isNotEmpty)
            CachedImageWidget(
              url: cat.categoryImage.validate(),
              height: rh(context, 56),
              width: rs(context, 56),
              fit: BoxFit.contain,
              placeHolderImage: '',
            )
          else
            Icon(Icons.category_rounded,
                size: rs(context, 48),
                color: primaryColor.withOpacity(0.6)),
          SizedBox(height: rh(context, 8)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rs(context, 8)),
            child: Text(
              cat.name.validate(),
              style: primaryTextStyle(
                size: (rs(context, TEXT_SIZE_BODY)).round(),
                color: appStore.isDarkMode
                    ? Colors.white
                    : appTextPrimaryColor,
                fontFamily: kHomeFontFamily,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────
// PLACEHOLDER CARD
// ─────────────────────────────────────────────
Widget homePlaceholderCard(
    BuildContext context, {
      required IconData icon,
      required String message,
    }) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
    child: Container(
      width: MediaQuery.sizeOf(context).width - (rs(context, 16) * 2),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(rs(context, 16)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: rs(context, 40),
                color: appStore.isDarkMode
                    ? Colors.white38
                    : appTextSecondaryColor),
            SizedBox(height: rh(context, 12)),
            Text(message,
                style: secondaryTextStyle(
                    size: (rs(context, LABEL_TEXT_SIZE.toDouble())).round(),
                    color: appStore.isDarkMode
                        ? Colors.white54
                        : appTextSecondaryColor,
                    fontFamily: kHomeFontFamily)),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────
// ACTIVITY CARD  – GetYourGuide style
// ─────────────────────────────────────────────
Widget homeActivityCard(BuildContext context, ServiceData service) {
  final cardWidth = rs(context, 270);
  final imageHeight = rh(context, 180);
  final cardHeight = rh(context, 330);

  final symbol = appConfigurationStore.currencySymbol.validate();
  final discountedPrice = service.getDiscountedPrice.toStringAsFixed(0);
  final hasDiscount = service.discount.validate() > 0;
  final originalPrice = service.price.validate().toStringAsFixed(0);

  Widget _stars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating.floor();
        final half = !filled && (i < rating);
        return Icon(
          half
              ? Icons.star_half_rounded
              : (filled ? Icons.star_rounded : Icons.star_outline_rounded),
          size: rs(context, 16),
          color: ratingBarColor,
        );
      }),
    );
  }

  return GestureDetector(
    onTap: () => ServiceDetailScreen(
      serviceId: service.id.validate(),
      service: service,
    ).launch(context),
    child: Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.only(right: rs(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(rs(context, 14)),
        border: Border.all(color: primaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.white70.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(rs(context, 12))),
                  child: CachedImageWidget(
                    url: service.firstServiceImage.validate(),
                    height: imageHeight,
                    width: cardWidth,
                    fit: BoxFit.cover,
                    placeHolderImage: '',
                  ),
                ),
                Positioned(
                  top: rh(context, 8),
                  right: rs(context, 8),
                  child: CircleAvatar(
                    radius: rs(context, 18),
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border,
                        size: rs(context, 20),
                        color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(rs(context, 12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    service.categoryName.validate(),
                    style: secondaryTextStyle(
                        size: (rs(context, TEXT_SIZE_SMALL)).round(),
                        color:secondcolor,
                        fontFamily: kHomeFontFamily),
                  ),
                  4.height,
                  Text(
                    service.name.validate(),
                    style: boldTextStyle(
                        size: (rs(context, TEXT_SIZE_SUBTITLE)).round(),
                        color: secondcolor,
                        fontFamily: kHomeFontFamily),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  6.height,
                  Text(
                    service.duration.validate(),
                    style: secondaryTextStyle(
                        size: (rs(context, TEXT_SIZE_SMALL)).round(),
                        color: secondcolor,
                        fontFamily: kHomeFontFamily),
                  ),
                  6.height,
                  Row(
                    children: [
                      _stars(service.totalRating.validate().floorToDouble()),
                      4.width,
                      Expanded(
                        child: Text(
                          '${service.totalRating.validate()} (${service.totalReview.validate()})',
                          style: secondaryTextStyle(
                              size: (rs(context, TEXT_SIZE_SMALL)).round(),
                              color: color,
                              fontFamily: kHomeFontFamily),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  8.height,
                  // const Spacer(),
                  if (hasDiscount) ...[
                    Text(
                      'From $symbol$originalPrice',
                      style: secondaryTextStyle(
                        size: (rs(context, TEXT_SIZE_SMALL)).round(),
                        color: color,
                        decoration: TextDecoration.lineThrough,
                        fontFamily: kHomeFontFamily,
                      ),
                    ),
                    SizedBox(height: rh(context, 4)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$symbol$discountedPrice',
                          style: boldTextStyle(
                              size: (rs(context, TEXT_SIZE_HEADING)).round(),
                              color: secondcolor,
                              fontFamily: kHomeFontFamily),
                        ),
                        SizedBox(width: rs(context, 6)),
                        Text(
                          'per adult',
                          style: secondaryTextStyle(
                              size: (rs(context, TEXT_SIZE_SMALL)).round(),
                              color: secondcolor,
                              fontFamily: kHomeFontFamily),
                        ),
                      ],
                    ),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'From ',
                          style: secondaryTextStyle(
                              size: (rs(context, TEXT_SIZE_BODY)).round(),
                              color: color,
                              fontFamily: kHomeFontFamily),
                        ),
                        Text(
                          '$symbol$discountedPrice',
                          style: boldTextStyle(
                              size: (rs(context, TEXT_SIZE_HEADING)).round(),
                              color: secondcolor,
                              fontFamily: kHomeFontFamily),
                        ),
                        SizedBox(width: rs(context, 6)),
                        Text(
                          'per adult',
                          style: secondaryTextStyle(
                              size: (rs(context, TEXT_SIZE_SMALL)).round(),
                              color: secondcolor,
                              fontFamily: kHomeFontFamily),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget homeServiceCard(BuildContext context, ServiceData service) =>
    homeActivityCard(context, service);

/// Legacy – keep for backward compat
Widget homeSearchBar(BuildContext context,
    {List<ServiceData>? featuredList}) {
  return const SizedBox.shrink();
}
class HomeSectionDivider extends StatelessWidget {
  const HomeSectionDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = appStore.isDarkMode
        ? Colors.white54
        : primaryColor.withOpacity(0.6);

    return SizedBox(
      height: rh(context, 12),
      width: double.infinity,
      child: CustomPaint(
        painter: _WaveLinePainter(color),
      ),
    );
  }
}

class _WaveLinePainter extends CustomPainter {
  final Color color;

  _WaveLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    double waveHeight = 10;
    double waveLength = 40;

    path.moveTo(0, size.height / 3);

    for (double i = 0; i < size.width; i += waveLength) {
      path.quadraticBezierTo(
        i + waveLength / 4,
        size.height / 2 - waveHeight,
        i + waveLength / 2,
        size.height / 2,
      );

      path.quadraticBezierTo(
        i + 3 * waveLength / 4,
        size.height / 2 + waveHeight,
        i + waveLength,
        size.height / 2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}