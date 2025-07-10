// import 'package:beauty_verse/widgets/my_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../utils/my_colors.dart';
// import '../utils/my_icons.dart';
// import '../utils/my_parsing_currency.dart';
// import 'my_image.dart';
// import 'my_image_assets.dart';
// import 'my_text.dart';

// class MyContentProduct extends StatelessWidget {
//   const MyContentProduct({
//     super.key,
//     required this.productImage,
//     required this.productVariant,
//     required this.image,
//     required this.name,
//     required this.totReview,
//     required this.totalSales,
//     required this.avgRating,
//     required this.wishlist,
//     required this.openDetail,
//     required this.addToWishlist,
//     required this.addToCart,
//   });

//   final List<dynamic> productImage, productVariant;
//   final String image, name, totReview, totalSales;
//   final dynamic avgRating;
//   final RxBool wishlist;
//   final VoidCallback openDetail, addToWishlist, addToCart;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: openDetail,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: AspectRatio(
//               aspectRatio: 174 / 165,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: MyColors.brokenWhite2,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: PageView.builder(
//                   // controller: _pageController,
//                   itemCount: productImage.length,
//                   itemBuilder: (context, index) => ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Stack(
//                       alignment: Alignment.bottomLeft,
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 174 / 165,
//                           child: MyImage(image: productImage[index]["image"]),
//                         ),
//                         Container(
//                           width: 48,
//                           height: 26,
//                           margin: EdgeInsets.only(left: 95),
//                           padding: EdgeInsets.only(right: 11),
//                           decoration: BoxDecoration(
//                             color: MyColors.bwBlack,
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(16),
//                             ),
//                           ),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: MyText(
//                               overflow: TextOverflow.ellipsis,
//                               text: "${productVariant[0]["weight"]}gr",
//                               fontSize: 8,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 108,
//                           height: 26,
//                           padding: EdgeInsets.fromLTRB(15, 0, 24, 0),
//                           decoration: BoxDecoration(
//                             color: MyColors.tosca,
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(8),
//                               topRight: Radius.circular(16),
//                             ),
//                           ),
//                           child: Center(
//                             child: MyText(
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               text: productVariant[0]["variantName"],
//                               fontSize: 8,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           MyText(
//             text: name,
//             fontWeight: FontWeight.w600,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(height: 4),
//           Row(
//             spacing: 4,
//             children: [
//               MyImageAssets(assets: MyIcons.icStar),
//               MyText(
//                 text: "$avgRating",
//                 color: MyColors.gray2,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//               MyText(
//                 text: "($totReview Review)",
//                 color: MyColors.bwGrayLighter,
//                 fontSize: 12,
//               ),
//             ],
//           ),
//           SizedBox(height: 2),
//           MyText(
//             text: "@totalSales terjual",
//             color: MyColors.gray2,
//             fontSize: 12,
//             namedArgs: {"totalSales": totalSales},
//           ),
//           SizedBox(height: 6),
//           (productVariant[0]["discount"] == 0)
//               ? SizedBox()
//               : Column(
//                   children: [
//                     Row(
//                       spacing: 8,
//                       children: [
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                           decoration: BoxDecoration(
//                             color: MyColors.redNegativeDarker,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                           child: MyText(
//                             text: "-${productVariant[0]["discount"]}%",
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         MyText(
//                           text: parsingCurrency(productVariant[0]["price"]),
//                           fontSize: 12,
//                           color: MyColors.gray2,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 6),
//                   ],
//                 ),
//           MyText(
//             text: parsingCurrency((productVariant[0]["discount"] == 0)
//                 ? productVariant[0]["price"]
//                 : productVariant[0]["priceAfterDiscount"]),
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//           SizedBox(height: 12),
//           Row(
//             spacing: 6,
//             children: [
//               GestureDetector(
//                 onTap: addToWishlist,
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     color: MyColors.bwWhite,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Obx(() => Icon(
//                         (wishlist.value)
//                             ? Icons.favorite
//                             : Icons.favorite_border,
//                         size: 20,
//                       )),
//                 ),
//               ),
//               Expanded(
//                 child: MyButton(
//                   height: 32,
//                   borderRadius: 8,
//                   text: "Tambah ke Keranjang",
//                   fontSize: 13,
//                   onTap: addToCart,
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
