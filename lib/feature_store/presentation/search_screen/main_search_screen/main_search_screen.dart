import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumia_app/core/commons/theme/app_colors.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/main_search_screen/bloc/main_search_bloc.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/main_search_screen/bloc/main_search_state.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/presentation/app_global_widgets.dart';
import '../search_overview_screen/search_overview_screen.dart';
import 'bloc/main_search_event.dart';

class MainSearchScreen extends StatelessWidget {
  const MainSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainSearchBloc>(
        lazy: false,
        create: (_) => MainSearchBloc(),
        child: BlocBuilder<MainSearchBloc, MainSearchState>(
        builder: (context,state) {

          final mainSearchBloc = context.read<MainSearchBloc>();


          return Scaffold(
          appBar: AppBar(
            toolbarHeight: 60.h,
            backgroundColor: Colors.white,
            elevation: 3,
            shadowColor: Colors.grey.withOpacity(.3),
            title: Text(
                "SEARCH",
              style: TextStyle(
                color: AppColors.smoothChinaRed,
                fontWeight: FontWeight.bold,
                fontSize: 26.sp
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: 1.sw,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                      SizedBox(
                        height: 45.h,
                      ),
                      Hero(
                        tag: "searchBar",
                        child: Container(
                          width: .92.sw,
                          child: ChinaSearchBar(
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
                            isActive: true,
                            onTextChanged: (value){
                                mainSearchBloc.add(SearchPromptChange(newPrompt: value));
                              },
                            onFieldSubmit: (value){
                              if(value.isNotEmpty && value != null){
                                Navigator.push(
                                    context,
                                    PageTransition(child: SearchOverviewScreen(searchPrompt: value), type: PageTransitionType.bottomToTop)
                                );
                              }
                            }
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      const Text(
                      "You can search for a product, a grocery or search from related informations like \" adidas, usb \" and so on...",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Hero(
                    //   tag: "ohio",
                    //   child: Container(
                    //     height: 20,
                    //     width: 20,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 3.h),
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                            ),
                          ),
                          Center(
                            child: Container(
                              color: Colors.white60,
                              padding: EdgeInsets.only(left: 5.h, right: 5.h),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.sinCityRed.withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
