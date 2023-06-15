import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_bloc.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_event.dart';

import '../commons/theme/app_colors.dart';

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
    this.onFieldSubmit,
  });

  final Icon leadingIcon;
  final String title;
  final String subtitle;
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
                            hintText: "Search anything you want..."
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
