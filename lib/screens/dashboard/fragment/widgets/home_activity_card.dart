// import '../imports.dart';
//
// class HomeActivityCard extends StatelessWidget {
//   final ServiceData service;
//
//   const HomeActivityCard({Key? key, required this.service}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cardWidth = rs(context, 270);
//     final cardHeight = rh(context, 330);
//
//     return GestureDetector(
//       onTap: () => ServiceDetailScreen(
//         serviceId: service.id.validate(),
//         service: service,
//       ).launch(context),
//       child: Container(
//         width: cardWidth,
//         height: cardHeight,
//         margin: EdgeInsets.only(right: rs(context, 12)),
//         decoration: BoxDecoration(
//           color: Colors.white70,
//           borderRadius: BorderRadius.circular(rs(context, 14)),
//           border: Border.all(color: primaryColor, width: 1),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ServiceImageSection(service: service),
//             ServiceInfoSection(service: service),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class ServiceImageSection extends StatelessWidget {
//   final ServiceData service;
//
//   const ServiceImageSection({Key? key, required this.service}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cardWidth = rs(context, 270);
//     final imageHeight = rh(context, 180);
//
//     return Expanded(
//       flex: 3,
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(rs(context, 12)),
//             ),
//             child: CachedImageWidget(
//               url: service.firstServiceImage.validate(),
//               height: imageHeight,
//               width: cardWidth,
//               fit: BoxFit.cover,
//               placeHolderImage: '',
//             ),
//           ),
//           Positioned(
//             top: rh(context, 8),
//             right: rs(context, 8),
//             child: const _FavoriteButton(),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class _FavoriteButton extends StatelessWidget {
//   const _FavoriteButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: rs(context, 18),
//       backgroundColor: Colors.white,
//       child: Icon(
//         Icons.favorite_border,
//         size: rs(context, 20),
//         color: Colors.grey.shade700,
//       ),
//     );
//   }
// }
// class ServiceInfoSection extends StatelessWidget {
//   final ServiceData service;
//
//   const ServiceInfoSection({Key? key, required this.service}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.all(rs(context, 12)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               service.categoryName.validate(),
//               style: secondaryTextStyle(
//                 size: (rs(context, TEXT_SIZE_SMALL)).round(),
//                 color: Colors.black,
//                 fontFamily: kHomeFontFamily,
//               ),
//             ),
//             4.height,
//             Text(
//               service.name.validate(),
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w700,
//                 fontSize: rs(context, TEXT_SIZE_SUBTITLE),
//                 color: secondcolor,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             6.height,
//             Text(
//               service.duration.validate(),
//               style: secondaryTextStyle(
//                 size: (rs(context, TEXT_SIZE_SMALL)).round(),
//                 color: secondcolor,
//                 fontFamily: kHomeFontFamily,
//               ),
//             ),
//             6.height,
//             RatingSection(service: service),
//             8.height,
//             PriceSection(service: service),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class RatingSection extends StatelessWidget {
//   final ServiceData service;
//
//   const RatingSection({Key? key, required this.service}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         RatingStars(rating: service.totalRating.validate().floorToDouble()),
//         4.width,
//         Expanded(
//           child: Text(
//             '${service.totalRating.validate()} (${service.totalReview.validate()})',
//             style: secondaryTextStyle(
//               size: (rs(context, TEXT_SIZE_SMALL)).round(),
//               color: secondcolor,
//               fontFamily: kHomeFontFamily,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
// class RatingStars extends StatelessWidget {
//   final double rating;
//
//   const RatingStars({Key? key, required this.rating}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (i) {
//         final filled = i < rating.floor();
//         final half = !filled && (i < rating);
//
//         return Icon(
//           half
//               ? Icons.star_half_rounded
//               : (filled ? Icons.star_rounded : Icons.star_outline_rounded),
//           size: rs(context, 16),
//           color: ratingBarColor,
//         );
//       }),
//     );
//   }
// }
// class PriceSection extends StatelessWidget {
//   final ServiceData service;
//
//   const PriceSection({Key? key, required this.service}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final symbol = appConfigurationStore.currencySymbol.validate();
//     final discountedPrice =
//     service.getDiscountedPrice.toStringAsFixed(0);
//     final hasDiscount = service.discount.validate() > 0;
//     final originalPrice =
//     service.price.validate().toStringAsFixed(0);
//
//     if (hasDiscount) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'From $symbol$originalPrice',
//             style: secondaryTextStyle(
//               size: (rs(context, TEXT_SIZE_SMALL)).round(),
//               decoration: TextDecoration.lineThrough,
//               fontFamily: kHomeFontFamily,
//             ),
//           ),
//           SizedBox(height: rh(context, 4)),
//           Row(
//             children: [
//               Text(
//                 '$symbol$discountedPrice',
//                 style: boldTextStyle(
//                   size: (rs(context, TEXT_SIZE_HEADING)).round(),
//                   color: secondcolor,
//                   fontFamily: kHomeFontFamily,
//                 ),
//               ),
//               SizedBox(width: rs(context, 6)),
//               Text(
//                 'per adult',
//                 style: secondaryTextStyle(
//                   size: (rs(context, TEXT_SIZE_SMALL)).round(),
//                   color: secondcolor,
//                   fontFamily: kHomeFontFamily,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     }
//
//     return Row(
//       children: [
//         Text(
//           'From ',
//           style: secondaryTextStyle(
//             size: (rs(context, TEXT_SIZE_BODY)).round(),
//             fontFamily: kHomeFontFamily,
//           ),
//         ),
//         Text(
//           '$symbol$discountedPrice',
//           style: boldTextStyle(
//             size: (rs(context, TEXT_SIZE_HEADING)).round(),
//             color: secondcolor,
//             fontFamily: kHomeFontFamily,
//           ),
//         ),
//         SizedBox(width: rs(context, 6)),
//         Text(
//           'per adult',
//           style: secondaryTextStyle(
//             size: (rs(context, TEXT_SIZE_SMALL)).round(),
//             color: secondcolor,
//             fontFamily: kHomeFontFamily,
//           ),
//         ),
//       ],
//     );
//   }
// }