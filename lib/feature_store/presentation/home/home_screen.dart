import 'package:cached_network_image/cached_network_image.dart';
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
      final ScrollController _scrollController = ScrollController();

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
              CategoriesTabBar(
                homeBloc: homeBloc,
                scrollToPopularProductsSection: (){
                  _scrollController.animateTo(
                    200.h,
                    duration: Duration(milliseconds: 1000), // Durée de l'animation (optionnelle)
                    curve: Curves.ease, // Courbe de l'animation (optionnelle)
                  );
                  print("scrolled fr mf !");
                }
              ),
              // On met le single child ici pour que l'item juste en haut reste fixé !
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      DiscountsSwiper(controller: _controller),
                      SizedBox(
                        height: 15.h,
                      ),
                      PopularProductsSection(homeBloc: homeBloc),
                      SizedBox(
                        height: 15.h,
                      )
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


