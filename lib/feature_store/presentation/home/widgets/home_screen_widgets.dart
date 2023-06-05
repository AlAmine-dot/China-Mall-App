import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/toolbox.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

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
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

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
                  height: 6.h,
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


