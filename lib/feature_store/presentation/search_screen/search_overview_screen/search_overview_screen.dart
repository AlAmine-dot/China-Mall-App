import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_bloc.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_event.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_overview_screen/bloc/search_overview_state.dart';

import '../../../../core/commons/theme/app_colors.dart';
import '../../../../core/presentation/app_global_widgets.dart';
import '../../home_screen/bloc/home_bloc.dart';

class SearchOverviewScreen extends StatelessWidget {
  const SearchOverviewScreen({Key? key, required this.searchPrompt}) : super(key: key);
  final String searchPrompt;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<SearchOverviewBloc>(
      lazy: false,
      create: (_){
        SearchOverviewBloc searchOverviewBloc = SearchOverviewBloc();

        searchOverviewBloc.add(SearchPromptChange(newPrompt: searchPrompt));
        searchOverviewBloc.add(SearchFieldSubmitted());

        return searchOverviewBloc;
      },
      child: BlocBuilder<SearchOverviewBloc, SearchOverviewState>(
        builder: (context, state) {

          final searchOverviewBloc = context.read<SearchOverviewBloc>();
          // final _textEditingController = TextEditingController();


          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60.h,
                backgroundColor: Colors.white,
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(.3),
                title: Text(
                  state.isLoading ? "..." : state.searchPrompt,
                  style: TextStyle(
                      color: AppColors.berryBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp
                  ),
                ),
              ),
            body: Container(
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 13.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45.h,
                    ),
                    Container(
                      width: .92.sw,
                      child: ChinaSearchBar(
                          leadingIcon: Icon(
                            Icons.search,
                            color: AppColors.berryBlack.withOpacity(.6),
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
                            searchOverviewBloc.add(SearchPromptChange(newPrompt: value));
                          },
                          onFieldSubmit: (value){
                            searchOverviewBloc.add(SearchFieldSubmitted());
                            // if(value.isNotEmpty && value != null){
                            //   Navigator.push(
                            //       context,
                            //       PageTransition(child: SearchOverviewScreen(searchPrompt: value), type: PageTransitionType.bottomToTop)
                            //   );
                            // }
                          },
                        hintText: state.searchPrompt,
                          // textEditingController: _textEditingController,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Text(
                          state.isLoading || state.searchResult == null ?
                          "Searching products..."
                          :
                          "${state.searchResult!.totalProductsFound} products found",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.berryBlack
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.gear,
                              color: AppColors.berryBlack,
                              size: 17,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Filter",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        DropdownButton<String>(
                          value: state.selectedFilterOption, // Valeur sélectionnée
                          hint: Text('Select an option'), // Texte d'indication lorsqu'aucune option n'est sélectionnée
                          onChanged: (newValue) {
                            searchOverviewBloc.add(SelectFilter(newFilterValue: newValue ?? ""));
                            // setState(() {
                            //   selectedValue = newValue!; // Met à jour la valeur sélectionnée
                            // });
                          },
                          items: <String>['Ratings', 'Relevance', 'Reviews']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                        child: SingleChildScrollView(child: state.searchResult == null || state.isLoading ?
                        Container(
                          height: 370.h,
                          child: Center(
                            child: CircularProgressIndicator(color: AppColors.sinCityRed),
                          ),
                        ) : ProductsGridFeed(categoryProducts: state.searchResult!))
                    )
                  ],
              ),
            ),
          );
        }
      ),
    );
  }
}
