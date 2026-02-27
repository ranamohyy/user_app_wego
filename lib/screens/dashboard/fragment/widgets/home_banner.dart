// import '../../../../model/category_model.dart';
// import '../../../notification/notification_screen.dart';
// import '../../../service/search_service_screen.dart';
// import '../imports.dart';
// import 'home_category_ships.dart';
//
// class HomeHeroBanner extends StatelessWidget {
//   final List<dynamic> items;
//   final List<CategoryData>? categories;
//   final int selectedCategoryIndex;
//   final ValueChanged<int>? onCategorySelected;
//
//   const HomeHeroBanner({
//     Key? key,
//     required this.items,
//     required this.categories,
//     required this.selectedCategoryIndex,
//     required this.onCategorySelected,
//   }) : super(key: key);
//
//   String _bannerImageUrl(dynamic item) {
//     return item.sliderImage ?? ''?.isNotEmpty == true
//         ? item.attchments.first
//         : '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final url = items.isNotEmpty ? _bannerImageUrl(items[0]) : '';
//     final height = context.height() * 0.5;
//
//     return SizedBox(
//       height: height,
//       width: double.infinity,
//       child: Stack(
//         children: [
//           /// Background
//           Positioned.fill(
//             child: url.isNotEmpty
//                 ? CachedImageWidget(
//               url: url,
//               height: height,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeHolderImage: '',
//             )
//                 : Container(
//               color: const Color(0xFF1C1F26),
//               child: Icon(
//                 Icons.explore_rounded,
//                 size: rs(context, 64),
//                 color: Colors.white24,
//               ),
//             ),
//           ),
//
//           /// Gradient
//           Positioned.fill(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   stops: const [0.0, 0.4, 1.0],
//                   colors: [
//                     Colors.black.withOpacity(0.35),
//                     Colors.transparent,
//                     Colors.black.withOpacity(0.92),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           /// Search Overlay
//           _HomeSearchOverlay(),
//
//           /// Text Content
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 100,
//             child: _HeroContent(),
//           ),
//
//           /// Category Chips
//           if (categories != null && categories!.isNotEmpty)
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: HomeCategoryChips(
//                 categories: categories!,
//                 selectedIndex: selectedCategoryIndex,
//                 onSelected: onCategorySelected,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
// class _HeroContent extends StatelessWidget {
//   const _HeroContent({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Find your next\nservice experience',
//                 style: boldTextStyle(
//                   size: (rs(context, TEXT_SIZE_HERO)).round(),
//                   color: Colors.white,
//                   fontFamily: kHomeFontFamily,
//                 ),
//               ),
//               SizedBox(height: rh(context, 12)),
//               GestureDetector(
//                 onTap: () =>
//                     SearchServiceScreen(featuredList: null).launch(context),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Learn more',
//                       style: secondaryTextStyle(
//                         size: (rs(context, TEXT_SIZE_SUBTITLE)).round(),
//                         color: Colors.white,
//                         fontFamily: kHomeFontFamily,
//                       ),
//                     ),
//                     SizedBox(width: rs(context, 4)),
//                     Icon(
//                       Icons.chevron_right,
//                       size: rs(context, 18.0),
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: rh(context, 20)),
//         SizedBox(height: rh(context, 16)),
//       ],
//     );
//   }
// }
// // class HomeSearchOverlay extends StatelessWidget {
// //   final List<ServiceData>? featuredList;
// //
// //   const HomeSearchOverlay({Key? key, this.featuredList})
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Positioned(
// //       top: context.statusBarHeight + rs(context, 12),
// //       left: rs(context, 16),
// //       right: rs(context, 16),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Material(
// //               color: Colors.black.withOpacity(0.55),
// //               borderRadius: BorderRadius.circular(rs(context, 30)),
// //               child: InkWell(
// //                 onTap: () => SearchServiceScreen(
// //                   featuredList: featuredList,
// //                 ).launch(context),
// //                 borderRadius: BorderRadius.circular(rs(context, 30)),
// //                 child: SizedBox(
// //                   height: rh(context, 48),
// //                   child: Row(
// //                     children: [
// //                       Icon(Icons.search_rounded,
// //                           size: rs(context, 20),
// //                           color: Colors.white70),
// //                       SizedBox(width: rs(context, 10)),
// //                       Text(
// //                         'Find places and things to do',
// //                         style: secondaryTextStyle(
// //                           size: (rs(context, LABEL_TEXT_SIZE.toDouble())).round(),
// //                           color: Colors.white70,
// //                           fontFamily: kHomeFontFamily,
// //                         ),
// //                       ),
// //                     ],
// //                   ).paddingSymmetric(horizontal: rs(context, 16)),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: rs(context, 12)),
// //           _NotificationBell(),
// //         ],
// //       ),
// //     );
// //   }
// // }
// class _NotificationBell extends StatelessWidget {
//   const _NotificationBell({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           width: rh(context, 48),
//           height: rh(context, 48),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.55),
//             shape: BoxShape.circle,
//           ),
//           child: IconButton(
//             icon: Icon(Icons.notifications_outlined,
//                 size: rs(context, 24),
//                 color: Colors.white),
//             onPressed: () => NotificationScreen().launch(context),
//           ),
//         ),
//         if (appStore.unreadCount.validate() > 0)
//           Positioned(
//             top: rs(context, 4),
//             right: rs(context, 4),
//             child: Container(
//               padding: EdgeInsets.all(rs(context, 4)),
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               child: Text(
//                 '${appStore.unreadCount > 9 ? '9+' : appStore.unreadCount}',
//                 style: primaryTextStyle(
//                   size: (rs(context, TEXT_SIZE_XS)).round(),
//                   color: Colors.white,
//                   fontFamily: kHomeFontFamily,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
// class _HomeSearchOverlay extends StatelessWidget {
//   const _HomeSearchOverlay({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: context.statusBarHeight + rh(context, 12),
//       left: rs(context, 16),
//       right: rs(context, 16),
//       child: Row(
//         children: [
//           /// Search Bar
//           Expanded(
//             child: GestureDetector(
//               onTap: () =>
//                   SearchServiceScreen(featuredList: null).launch(context),
//               child: Container(
//                 height: rh(context, 48),
//                 padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.search, color: Colors.grey),
//                     SizedBox(width: rs(context, 8)),
//                     Text(
//                       "Search services...",
//                       style: secondaryTextStyle(
//                         color: Colors.grey,
//                         fontFamily: kHomeFontFamily,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(width: rs(context, 12)),
//
//           /// Notification Bell
//           Container(
//             height: rh(context, 48),
//             width: rh(context, 48),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.notifications_none,
//               color: primaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }