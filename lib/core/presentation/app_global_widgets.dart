import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_bloc.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_event.dart';

import '../../feature_store/domain/model/product.dart';
import '../../feature_store/domain/model/product_store.dart';
import '../commons/theme/app_colors.dart';
import '../commons/utils/toolbox.dart';

// SEARCH SEARCH BAR :

class ChinaSearchBar extends StatelessWidget {
  const ChinaSearchBar({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
    required this.isActive,
    this.textEditingController,
    this.onTextChanged,
    this.onFieldSubmit, this.hintText,
  });

  final Icon leadingIcon;
  final String title;
  final String subtitle;
  final String? hintText;
  final Icon trailingIcon;
  final bool isActive;
  final TextEditingController? textEditingController;
  final Function(String value)? onTextChanged;
  final Function(String value)? onFieldSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      height: 52.h,
      width: 1.sw,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0,0),
                color: Colors.grey.withOpacity(.4)
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50.h,
            width: 15.w,
            child: leadingIcon,
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: this.isActive ? 0.h : 4.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  this.isActive ? Container(
                    // color: AppColors.berryBlack,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: textEditingController,
                          onChanged:(value)=>onTextChanged!(value),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: hintText ?? "Search anything you want..."
                          ),
                          keyboardType: TextInputType.text,
                          onSubmitted: (value){
                            // print("On va faire le tchololo :" + value);
                              onFieldSubmit!(value);
                          }
                        ),
                      ],
                    ),
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColors.berryBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Container(
            child: SizedBox(
              height: 30.h,
              // Mettre .h en width n'est pas une très bonne pratique maiiis on verra...
              width: 30.h,
              child: trailingIcon,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(.6),
                  width: .8,
                ),
                borderRadius: BorderRadius.circular(15.h)
            ),
          )
        ],
      ),
    );
  }
}

// PRODUCTS GRID FEED :

class ProductsGridFeed extends StatelessWidget {
  const ProductsGridFeed({
    super.key, required this.categoryProducts,
    // required this.state,
  });

  // final HomeState state;
  final ProductStore categoryProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 230,
            mainAxisExtent: 285,
            childAspectRatio: 1 / 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7),
        shrinkWrap: true,
        physics:
        const NeverScrollableScrollPhysics(),
        itemCount: categoryProducts.products.length,
        itemBuilder: (_, index) {
          final Product product = categoryProducts!.products[index]!;
          return ProductSmallCard(product: product);
        });
  }
}

class ProductSmallCard extends StatelessWidget {
  const ProductSmallCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 180.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(
                  15),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/placeholder.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/placeholder.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 22.h,
                    width: 22.h,
                    child: Center(
                        child: Icon(
                          Icons.shopping_cart,
                          color: AppColors
                              .sinCityRed,
                          size: 17,
                        )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius
                            .circular(
                            15)),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 164.w,
                    padding:
                    EdgeInsets.only(
                        top: 35.h,
                        left: 5.w,
                        bottom: 2.h),
                    decoration:
                    BoxDecoration(
                        gradient:
                        LinearGradient(
                          colors: [
                            Colors
                                .transparent,
                            Colors.black
                                .withOpacity(
                                .9)
                          ], // Remplacez les couleurs par celles de votre choix
                          begin: Alignment
                              .topCenter,
                          end: Alignment
                              .bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft:
                            Radius.circular(
                                15),
                            bottomRight:
                            Radius.circular(
                                15))),
                    child: Row(
                      children: List.generate(5, (index) {
                        if (index < product.rating.floor()) {
                          // L'index est inférieur à la note du produit, afficher une étoile pleine
                          return Icon(Icons.star, color: AppColors.chinaYellow);
                        } else {
                          // L'index est supérieur ou égal à la note du produit, afficher une étoile vide
                          return Icon(Icons.star_border, color: AppColors.chinaYellow);
                        }
                      }),

                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 5.h),
            width: 1.sw,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  truncateText(product.title,20),
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "${formatPrice(convertDollarsToFrancCFA(product.price.toDouble()))} FCFA",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight:
                      FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                        '${formatPrice(convertDollarsToFrancCFA(product.nondiscountPrice.toDouble()))} FCFA',
                        style: TextStyle(
                          color: Colors.grey
                              .withOpacity(
                              .9),
                          fontSize: 13.sp,
                          decoration:
                          TextDecoration
                              .lineThrough, // Ajout de la décoration de ligne barrée
                          decorationColor: Colors
                              .grey
                              .withOpacity(
                              .9), // Couleur de la ligne barrée
                          decorationThickness:
                          2.0, // Épaisseur de la ligne barrée
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      padding: EdgeInsets
                          .symmetric(
                          horizontal:
                          2.w,
                          vertical:
                          1.h),
                      height: 15.h,
                      width: 37.h,
                      decoration: BoxDecoration(
                          color: AppColors
                              .smoothChinaRed
                              .withOpacity(
                              .5),
                          borderRadius:
                          BorderRadius
                              .circular(
                              15)),
                      child: Center(
                        child: Text(
                          "-${product.discountPercentage.truncate()}%",
                          style: TextStyle(
                              color: AppColors
                                  .smoothChinaRed,
                              fontWeight:
                              FontWeight
                                  .bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

