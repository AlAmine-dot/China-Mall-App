import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumia_app/core/utils/toolbox.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_bloc.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_event.dart';
import 'package:lumia_app/feature_store/presentation/home/bloc/home_state.dart';
import 'package:lumia_app/feature_store/presentation/home/widgets/home_screen_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/theme/app_colors.dart';
import '../../domain/model/product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      final homeBloc = context.read<HomeBloc>();
      final _controller = PageController();
      final List<Map> myProducts = List.generate(
          10, (index) => {"id": index, "name": "Product ${index}"}).toList();

      return DefaultTabController(
        length: state.categories.length,
        child: Scaffold(
          appBar: SearchTopAppBar(
            leadingIcon: Icon(
              Icons.search,
              color: AppColors.berryBlack,
            ),
            trailingIcon: Icon(
              FontAwesomeIcons.sliders,
              color: AppColors.berryBlack,
              size: 17,
            ),
            title: "What would you like ?",
            subtitle: "Shoes, glasses... ask us anything !",
          ),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoriesTabBar(homeBloc: homeBloc),
              // On met le single child ici pour que l'item juste en haut reste fixé !
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DiscountsSwiper(controller: _controller),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
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
                                      state
                                                  .categories[
                                                      state.selectedCategoryTab]
                                                  .categoryName
                                                  .length <
                                              14
                                          ? "Popular products in ${state.categories[state.selectedCategoryTab].categoryName}"
                                          : "Popular products in \n${state.categories[state.selectedCategoryTab].categoryName}",
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            state.categoryProductsLoading ? Container(
                              width: 1.sw,
                              height: 300.h,
                              child: Center(
                                child: CircularProgressIndicator(color: AppColors.smoothChinaRed),
                              ),
                            ) : Container(
                              width: 1.sw,
                              // height: 500.h,
                              child: GridView.builder(
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
                                                    image: DecorationImage(
                                                      image: NetworkImage(product.thumbnail),
                                                      fit: BoxFit.cover,
                                                    )),
                                                child: Stack(
                                                  children: [
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
                                                          children: [
                                                            Icon(Icons.star,
                                                                color: AppColors
                                                                    .chinaYellow),
                                                            Icon(Icons.star,
                                                                color: AppColors
                                                                    .chinaYellow),
                                                            Icon(Icons.star,
                                                                color: AppColors
                                                                    .chinaYellow),
                                                            Icon(Icons.star,
                                                                color: AppColors
                                                                    .chinaYellow),
                                                            Icon(
                                                                Icons
                                                                    .star_border,
                                                                color: AppColors
                                                                    .chinaYellow)
                                                          ],
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
                                                      product.title,
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Text(
                                                      "${convertDollarsToFrancCFA(product.price.toDouble())} FCFA",
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
                                                                '200.000 FCFA',
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
                                      }),
                            )
                          ],
                        ),
                      ),
                      Center(child: Text("Hello lumia !"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
