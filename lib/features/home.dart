// import 'package:booking_system_flutter/component/cached_image_widget.dart';
// import 'package:booking_system_flutter/component/image_border_component.dart';
// import 'package:booking_system_flutter/component/loader_widget.dart';
// import 'package:booking_system_flutter/main.dart';
// import 'package:booking_system_flutter/model/category_model.dart';
// import 'package:booking_system_flutter/model/dashboard_model.dart';
// import 'package:booking_system_flutter/model/service_data_model.dart';
// import 'package:booking_system_flutter/network/rest_apis.dart';
// import 'package:booking_system_flutter/screens/dashboard/shimmer/dashboard_shimmer.dart';
// import 'package:booking_system_flutter/screens/notification/notification_screen.dart';
// import 'package:booking_system_flutter/screens/service/search_service_screen.dart';
// import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
// import 'package:booking_system_flutter/screens/service/view_all_service_screen.dart';
// import 'package:booking_system_flutter/utils/colors.dart';
// import 'package:booking_system_flutter/utils/constant.dart';
// import 'package:booking_system_flutter/utils/images.dart';
// import 'package:booking_system_flutter/utils/string_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:nb_utils/nb_utils.dart';
//
// import '../../../component/empty_error_state_widget.dart';
//
// const String _kDashboardSelectIndexKey = 'dashboardSelectIndex';
//
// class DashboardFragment extends StatefulWidget {
//   @override
//   _DashboardFragmentState createState() => _DashboardFragmentState();
// }
//
// class _DashboardFragmentState extends State<DashboardFragment> {
//   Future<DashboardResponse>? future;
//
//   @override
//   void initState() {
//     super.initState();
//     init(showLoader: false);
//     setStatusBarColorChange();
//     LiveStream().on(LIVESTREAM_UPDATE_DASHBOARD, (p0) async {
//       await init();
//     });
//   }
//
//   Future<void> init({bool showLoader = true}) async {
//     future = userDashboard(isCurrentLocation: false);
//     setState(() {});
//   }
//
//   Future<void> setStatusBarColorChange() async {
//     setStatusBarColor(
//       statusBarIconBrightness:
//       appStore.isDarkMode ? Brightness.light : Brightness.dark,
//       Colors.transparent,
//       delayInMilliSeconds: 800,
//     );
//   }
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SnapHelperWidget<DashboardResponse>(
//             initialData: cachedDashboardResponse,
//             future: future,
//             errorBuilder: (error) {
//               return NoDataWidget(
//                 title: error,
//                 imageWidget: const ErrorStateWidget(),
//                 retryText: language.reload,
//                 onRetry: () async => await init(),
//               );
//             },
//             loadingWidget: DashboardShimmer(),
//             onSuccess: (snap) => _PremiumHomeBody(
//               snap: snap,
//               onRefresh: () async {
//                 setValue(LAST_APP_CONFIGURATION_SYNCED_TIME, 0);
//                 await init();
//                 return await 2.seconds.delay;
//               },
//             ),
//           ),
//           Observer(
//             builder: (context) {
//               final isLoading = appStore.isLoading;
//               return LoaderWidget().visible(isLoading.validate());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _PremiumHomeBody extends StatefulWidget {
//   final DashboardResponse snap;
//   final Future<void> Function() onRefresh;
//
//   const _PremiumHomeBody({required this.snap, required this.onRefresh});
//
//   @override
//   State<_PremiumHomeBody> createState() => _PremiumHomeBodyState();
// }
//
// class _PremiumHomeBodyState extends State<_PremiumHomeBody> {
//   static const double _sectionSpacing = 24;
//   static const double _horizontalPadding = 18;
//   static const double _searchBarRadius = 30;
//   static const double _cardRadius = 16;
//   static const double _bannerRadius = 20;
//
//   List<ServiceData> get _allServices => widget.snap.service.validate();
//   List<ServiceData> get _topRated => widget.snap.featuredServices.validate();
//   List<CategoryData> get _categories => widget.snap.category.validate();
//   List<dynamic> get _bannerItems {
//     final promo = widget.snap.promotionalBanner.validate();
//     if (promo.isNotEmpty && appConfigurationStore.isPromotionalBanner)
//       return promo;
//     return widget.snap.slider.validate();
//   }
//
//   List<ServiceData> _servicesForCategory(int categoryId) {
//     return _allServices.where((s) => s.categoryId == categoryId).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: widget.onRefresh,
//       color: primaryColor,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: const EdgeInsets.only(bottom: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildAppBar(),
//             _buildSearchBar(),
//             SizedBox(height: _sectionSpacing),
//             _buildPromoBanner(),
//             SizedBox(height: _sectionSpacing),
//             _buildTopRatedSection(),
//             SizedBox(height: _sectionSpacing),
//             _buildCategoriesSection(),
//             ...List.generate(_categories.length, (i) {
//               final cat = _categories[i];
//               final services = _servicesForCategory(cat.id ?? 0);
//               return Padding(
//                 padding: const EdgeInsets.only(top: _sectionSpacing),
//                 child: _buildCategoryServicesSection(
//                     cat.name.validate(), services, cat.id),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAppBar() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.only(
//         top: context.statusBarHeight + 12,
//         left: _horizontalPadding,
//         right: _horizontalPadding,
//         bottom: 12,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Hello 👋',
//                   style: secondaryTextStyle(
//                     size: 14,
//                     color: appStore.isDarkMode
//                         ? Colors.white70
//                         : appTextSecondaryColor,
//                   ),
//                 ),
//                 4.height,
//                 Text(
//                   appStore.isLoggedIn && appStore.userFullName.trim().isNotEmpty
//                       ? appStore.userFullName
//                       : 'Guest',
//                   style: boldTextStyle(
//                     size: 20,
//                     color: appStore.isDarkMode
//                         ? Colors.white
//                         : appTextPrimaryColor,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   IconButton(
//                     icon: ic_notification.iconImage(
//                         size: 24,
//                         color: appStore.isDarkMode
//                             ? Colors.white
//                             : appTextPrimaryColor),
//                     onPressed: () => NotificationScreen().launch(context),
//                   ),
//                   if (appStore.unreadCount.validate() > 0)
//                     Positioned(
//                       top: 6,
//                       right: 6,
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: const BoxDecoration(
//                             color: Colors.red, shape: BoxShape.circle),
//                         child: Text(
//                           '${appStore.unreadCount > 9 ? '9+' : appStore.unreadCount}',
//                           style:
//                           primaryTextStyle(size: 10, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               8.width,
//               GestureDetector(
//                 onTap: () {
//                   if (appStore.isLoggedIn) {
//                     LiveStream().emit(_kDashboardSelectIndexKey, 4);
//                   }
//                 },
//                 child: appStore.isLoggedIn &&
//                     appStore.userProfileImage.validate().isNotEmpty
//                     ? ImageBorder(
//                     src: appStore.userProfileImage, height: 40, width: 40)
//                     : CircleAvatar(
//                   radius: 20,
//                   backgroundColor: primaryColor.withValues(alpha: 0.2),
//                   child: ic_profile2.iconImage(
//                       size: 24, color: primaryColor),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//       child: Material(
//         color: context.cardColor,
//         borderRadius: BorderRadius.circular(_searchBarRadius),
//         elevation: 2,
//         shadowColor: Colors.black.withValues(alpha: 0.06),
//         child: InkWell(
//           onTap: () => SearchServiceScreen(
//               featuredList: _topRated.isEmpty ? _allServices : _topRated)
//               .launch(context),
//           borderRadius: BorderRadius.circular(_searchBarRadius),
//           child: Container(
//             height: 52,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             child: Row(
//               children: [
//                 Icon(Icons.search_rounded,
//                     size: 24,
//                     color: appStore.isDarkMode
//                         ? Colors.white54
//                         : appTextSecondaryColor),
//                 12.width,
//                 Text(
//                   'Search for services...',
//                   style: secondaryTextStyle(
//                       size: 15,
//                       color: appStore.isDarkMode
//                           ? Colors.white54
//                           : appTextSecondaryColor),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPromoBanner() {
//     final items = _bannerItems;
//     return SizedBox(
//       height: 160,
//       child: items.isEmpty
//           ? _placeholderBanner()
//           : PageView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           String? imageUrl;
//           if (item is SliderModel) {
//             imageUrl = item.sliderImage;
//           } else if (item is PromotionalBannerModel) {
//             imageUrl = item.image;
//           }
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: _horizontalPadding),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(_bannerRadius),
//               child: CachedImageWidget(
//                 url: imageUrl.validate(),
//                 height: 160,
//                 width: context.width(),
//                 fit: BoxFit.cover,
//                 placeHolderImage: '',
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _placeholderBanner() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           color: primaryColor.withValues(alpha: 0.08),
//           borderRadius: BorderRadius.circular(_bannerRadius),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Icon(Icons.campaign_rounded,
//               size: 48, color: primaryColor.withValues(alpha: 0.4)),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopRatedSection() {
//     final list = _topRated;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Top Rated Services',
//                 style: boldTextStyle(
//                     size: 18,
//                     color: appStore.isDarkMode
//                         ? Colors.white
//                         : appTextPrimaryColor),
//               ),
//               if (list.isNotEmpty)
//                 TextButton(
//                   onPressed: () => ViewAllServiceScreen(
//                     categoryName: language.featuredServices,
//                     isFeatured: '1',
//                     isFromCategory: false,
//                   ).launch(context),
//                   child: Text('See All',
//                       style: secondaryTextStyle(size: 14, color: primaryColor)),
//                 ),
//             ],
//           ),
//         ),
//         12.height,
//         SizedBox(
//           height: 220,
//           child: list.isEmpty
//               ? _placeholderCard(
//             icon: Icons.star_rounded,
//             message: 'No top rated services yet',
//           )
//               : ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(
//                 horizontal: _horizontalPadding),
//             itemCount: list.length,
//             itemBuilder: (context, index) {
//               final service = list[index];
//               return _ServiceCard(service: service, radius: _cardRadius);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCategoriesSection() {
//     final list = _categories;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//           child: Text(
//             'Explore Categories',
//             style: boldTextStyle(
//                 size: 18,
//                 color:
//                 appStore.isDarkMode ? Colors.white : appTextPrimaryColor),
//           ),
//         ),
//         16.height,
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 1.1,
//             ),
//             itemCount: list.length,
//             itemBuilder: (context, index) {
//               final cat = list[index];
//               return _CategoryCard(category: cat, radius: _cardRadius);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCategoryServicesSection(
//       String categoryName, List<ServiceData> services, int? categoryId) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 categoryName,
//                 style: boldTextStyle(
//                     size: 17,
//                     color: appStore.isDarkMode
//                         ? Colors.white
//                         : appTextPrimaryColor),
//               ),
//               if (services.isNotEmpty && categoryId != null)
//                 TextButton(
//                   onPressed: () => ViewAllServiceScreen(
//                     categoryId: categoryId,
//                     categoryName: categoryName,
//                     isFromCategory: true,
//                   ).launch(context),
//                   child: Text('See All',
//                       style: secondaryTextStyle(size: 14, color: primaryColor)),
//                 ),
//             ],
//           ),
//         ),
//         12.height,
//         SizedBox(
//           height: 220,
//           child: services.isEmpty
//               ? _placeholderCard(
//             icon: Icons.build_circle_outlined,
//             message: 'No services available',
//           )
//               : ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(
//                 horizontal: _horizontalPadding),
//             itemCount: services.length,
//             itemBuilder: (context, index) {
//               return _ServiceCard(
//                   service: services[index], radius: _cardRadius);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _placeholderCard({required IconData icon, required String message}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
//       child: Container(
//         width: context.width() - (_horizontalPadding * 2),
//         decoration: BoxDecoration(
//           color: context.cardColor,
//           borderRadius: BorderRadius.circular(_cardRadius),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon,
//                   size: 40,
//                   color: appStore.isDarkMode
//                       ? Colors.white38
//                       : appTextSecondaryColor),
//               12.height,
//               Text(
//                 message,
//                 style: secondaryTextStyle(
//                     size: 14,
//                     color: appStore.isDarkMode
//                         ? Colors.white54
//                         : appTextSecondaryColor),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _CategoryCard extends StatefulWidget {
//   final CategoryData category;
//   final double radius;
//
//   const _CategoryCard({required this.category, required this.radius});
//
//   @override
//   State<_CategoryCard> createState() => _CategoryCardState();
// }
//
// class _CategoryCardState extends State<_CategoryCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         duration: const Duration(milliseconds: 100), vsync: this);
//     _scale = Tween<double>(begin: 1, end: 0.97)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cat = widget.category;
//     final colorVal = cat.color.validate(value: 'E8E8E8');
//     Color bgColor;
//     try {
//       bgColor = colorVal.startsWith('#')
//           ? Color(int.parse(colorVal.substring(1), radix: 16) + 0xFF000000)
//           : '${colorVal.length == 6 ? '#' : ''}$colorVal'.toColor();
//     } catch (_) {
//       bgColor = context.cardColor;
//     }
//     return ScaleTransition(
//       scale: _scale,
//       child: GestureDetector(
//         onTapDown: (_) => _controller.forward(),
//         onTapUp: (_) => _controller.reverse(),
//         onTapCancel: () => _controller.reverse(),
//         onTap: () => ViewAllServiceScreen(
//           categoryId: cat.id,
//           categoryName: cat.name,
//           isFromCategory: true,
//         ).launch(context),
//         child: Container(
//           decoration: BoxDecoration(
//             color: bgColor.withValues(alpha: 0.25),
//             borderRadius: BorderRadius.circular(widget.radius),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.06),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(widget.radius),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (cat.categoryImage.validate().isNotEmpty)
//                   CachedImageWidget(
//                     url: cat.categoryImage.validate(),
//                     height: 56,
//                     width: 56,
//                     fit: BoxFit.contain,
//                     circle: false,
//                     placeHolderImage: '',
//                   )
//                 else
//                   Icon(Icons.category_rounded,
//                       size: 48, color: primaryColor.withValues(alpha: 0.6)),
//                 8.height,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(
//                     cat.name.validate(),
//                     style: primaryTextStyle(
//                         size: 13,
//                         color: appStore.isDarkMode
//                             ? Colors.white
//                             : appTextPrimaryColor),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _ServiceCard extends StatelessWidget {
//   final ServiceData service;
//   final double radius;
//
//   const _ServiceCard({required this.service, required this.radius});
//
//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = service.firstServiceImage;
//     return GestureDetector(
//       onTap: () =>
//           ServiceDetailScreen(serviceId: service.id.validate()).launch(context),
//       child: Container(
//         width: 160,
//         margin: const EdgeInsets.only(right: 12),
//         decoration: BoxDecoration(
//           color: context.cardColor,
//           borderRadius: BorderRadius.circular(radius),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.06),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
//               child: CachedImageWidget(
//                 url: imageUrl.validate(),
//                 height: 120,
//                 width: 160,
//                 fit: BoxFit.cover,
//                 placeHolderImage: '',
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     service.name.validate(),
//                     style: primaryTextStyle(
//                         size: 14,
//                         color: appStore.isDarkMode
//                             ? Colors.white
//                             : appTextPrimaryColor),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   4.height,
//                   Text(
//                     '${appConfigurationStore.currencySymbol.validate()}${service.getDiscountedPrice.toStringAsFixed(0)}',
//                     style: boldTextStyle(size: 14, color: primaryColor),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
