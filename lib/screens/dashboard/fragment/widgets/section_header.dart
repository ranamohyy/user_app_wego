// import '../imports.dart';
//
// class SectionHeader extends StatelessWidget {
//   final String title;
//   final VoidCallback? onSeeAll;
//
//   const SectionHeader({
//     Key? key,
//     required this.title,
//     this.onSeeAll,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: rs(context, 16)),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: GoogleFonts.poppins(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w700,
//                 color: secondcolor,
//               ),
//             ),
//           ),
//           if (onSeeAll != null)
//             GestureDetector(
//               onTap: onSeeAll,
//               child: Text(
//                 'See all',
//                 style: secondaryTextStyle(
//                   size: (rs(context, LABEL_TEXT_SIZE.toDouble())).round(),
//                   color: color,
//                   fontFamily: kHomeFontFamily,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }