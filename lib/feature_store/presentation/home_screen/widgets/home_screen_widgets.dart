import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/commons/theme/app_colors.dart';
import '../../../../core/commons/utils/toolbox.dart';
import '../../../domain/model/product.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

// SEARCH TOP APP BAR :

class SearchTopAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final String subtitle;
  final Icon leadingIcon;
  final Icon trailingIcon;

  const SearchTopAppBar({
    super.key, required this.title, required this.subtitle, required this.leadingIcon, required this.trailingIcon,
  });

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70.h,
      backgroundColor: Colors.white,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        height: 50.h,
        width: 1.sw,
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
                margin: EdgeInsets.symmetric(vertical: 3.h),
                child: Column(
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
      ),
    );
  }

}

// SEARCH TOP APP BAR :

class CategoriesTabBar extends StatelessWidget {
  const CategoriesTabBar({
    super.key,
    required this.homeBloc, required this.scrollToPopularProductsSection,
  });

  final HomeBloc homeBloc;
  final Function scrollToPopularProductsSection;

  @override
  Widget build(BuildContext context) {

    final state = homeBloc.state;

    return Container(
      // padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0,0),
                color: Colors.grey.withOpacity(.4)
            )
          ]
      ),
      // padding: EdgeInsets.only(bottom: 10.h),
      child: state.categoriesLoading ?
      Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Center(child: CircularProgressIndicator(color: AppColors.smoothChinaRed))
      ) : TabBar(
        // controller: _tabController,
        onTap: (int index){
          homeBloc.add(SelectCategory(index));
          scrollToPopularProductsSection();
          print("testing bro");
        },
        indicatorColor: Colors.red,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        isScrollable: true,
        tabs: state.categories.map((category) {
          final index = state.categories.indexOf(category);
          return Tab(
            child: Column(
              children: [
                Icon(
                  category.categoryIcon,
                  color: state.selectedCategoryTab == index ? Colors.black : Colors.grey,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  capitalizeFirstLetter(category.categoryName),
                  style: TextStyle(
                    color: state.selectedCategoryTab == index ? Colors.black : Colors.grey,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// DISCOUNTS SWIPER :

class DiscountsSwiper extends StatelessWidget {
  const DiscountsSwiper({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 7.h, left: 10.w, right: 10.w),
          height: 160.h,
          child: Stack(
            children: [
              PageView(
                controller: _controller,
                children: [
                  MainSwiperPage(),
                  GenericSwiperPage(
                    mainText: "30% OFF During \nTabaski",
                    buttonText: "For real ?",
                    gradientColors: [AppColors.sinCityRed, AppColors.smoothChinaRed],
                    swiperImageComponent:
                    Positioned(
                      right: 0,
                      top: 15.h,
                      child: Container(
                        height: 150.w,
                        width: 150.w,
                        child: Image.asset("assets/images/hand_bags.png"),
                      ),
                    ),
                  ),
                  GenericSwiperPage(
                    mainText: "15% Discount on \nhome furnitures",
                    buttonText: "Show me",
                    gradientColors: [AppColors.smoothChinaRed, AppColors.chinaYellow],
                    swiperImageComponent:
                    Positioned(
                      right: 0,
                      top: 15.h,
                      child: Container(
                        height: 150.w,
                        width: 150.w,
                        child: Image.asset("assets/images/furniture_1.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          // alignment: Alignment(0, 0.67),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(
                dotColor: Colors.grey.withOpacity(.4),
                activeDotColor: AppColors.smoothChinaRed,
                dotHeight: 8,
                dotWidth: 13,
              ),
            )),
      ],
    );
  }
}

// SWIPER PAGES :

class GenericSwiperPage extends StatelessWidget {
  final List<Color> gradientColors;
  final String mainText;
  final String buttonText;
  final Positioned swiperImageComponent;

  const GenericSwiperPage({
    super.key, required this.gradientColors, required this.mainText, required this.buttonText, required this.swiperImageComponent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors, // Remplacez les couleurs par celles de votre choix
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30.h,
            left: 15.w,
            child: Text(
              mainText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.sp
              ),
            ),
          ),
          swiperImageComponent,
          Positioned(
            bottom: 20.h,
            left: 15.w,
            child: GestureDetector(
              onTap: (){
                print("We already have it at home, chris.");
              },
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
                height: 40.h,
                width: 140.w,
                child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp
                      ),
                    )
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MainSwiperPage extends StatelessWidget {
  const MainSwiperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/swiper_1.png'),
            fit: BoxFit.cover,
          ),
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Stack(
          children: [
            Positioned(
              top: 55.h,
              left: 10.w,
              child: Text(
                "Welcome to CHINA MALL",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23.sp
                ),
              ),
            ),
            Positioned(
              top: 87.h,
              left: 10.w,
              child: Text(
                "7500sqft of items near you !",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp
                ),
              ),
            )

          ]
      ),
    );
  }
}

// POPULAR SECTION :

class PopularProductsSection extends StatelessWidget {
  final HomeBloc homeBloc;

  const PopularProductsSection({
    super.key, required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {

    final state = homeBloc.state;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13.w),
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44.h,
            child: state.categoriesLoading
                ? const Text(
              "Popular products in ...",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
                : Text(
              "Popular products in ${truncateText(state.categories[state.selectedCategoryTab].categoryName, 13)}",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          state.categoryProductsLoading ? Container(
            width: 1.sw,
            height: 600.h,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.smoothChinaRed),
            ),
          ) : Container(
            width: 1.sw,
            // height: 500.h,
            child: state.categoryProducts == null ? Container() : ProductsGridFeed(state: state),
          )
        ],
      ),
    );
  }
}

// PRODUCTS GRID FEED :

class ProductsGridFeed extends StatelessWidget {
  const ProductsGridFeed({
    super.key,
    required this.state,
  });

  final HomeState state;

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
        itemCount: state
            .categoryProducts?.products.length,
        itemBuilder: (_, index) {
          final Product product = state
              .categoryProducts!.products[index]!;
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


