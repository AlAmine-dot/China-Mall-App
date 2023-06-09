import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:lumia_app/core/commons/theme/app_colors.dart';
import 'package:lumia_app/feature_store/presentation/home_screen/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../feature_store/presentation/search_screen/search_screen.dart';
import '../root_screen/root_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: (){
              // Ce fut difficile d'architecturer avec le Shell donc je reviens sur le bon vieux navigator
                Navigator.pushReplacement(
                    context,
                    PageTransition(child: RootScreen(), type: PageTransitionType.fade)
                );
              // Visiblement peu importe le package, la première transition de l'app ne peut jamais
              // avoir d'animation.. nous reviendrons sur tout ça plus tard, pour le moment continue
              // d'architecturer
              //   context.pushReplacement("/home");
            },
            child: Text(
              "ONBOARDING",
              style: TextStyle(
                color: AppColors.smoothChinaRed,
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
