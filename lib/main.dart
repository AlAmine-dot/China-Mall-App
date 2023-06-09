import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumia_app/core/commons/theme/app_colors.dart';
import 'package:lumia_app/core/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:lumia_app/feature_store/di/locator.dart';
import 'package:lumia_app/feature_store/presentation/search_screen/search_screen.dart';
import 'core/presentation/root_screen/root_screen.dart';
import 'feature_store/presentation/cart_screen/cart_screen.dart';
import 'feature_store/presentation/home_screen/home_screen.dart';
import 'feature_store/presentation/profile_screen/profile_screen.dart';

void main() {
  setupStoreDependencies();
  runApp(const LumiaApp());
}

class LumiaApp extends StatelessWidget {
  const LumiaApp({super.key});

  @override
  Widget build(BuildContext context) {

    // final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
    // final GlobalKey<NavigatorState> _shellNavigator = GlobalKey(debugLabel: 'shell');
    //
    // final GoRouter _router = GoRouter(
    //   navigatorKey: _rootNavigator,
    //   initialLocation: "/",
    //   routes: [
    //     GoRoute(
    //       path: "/",
    //       builder: (context, state) => const OnboardingScreen(),
    //       routes: [
    //         ShellRoute(
    //             navigatorKey: _shellNavigator,
    //             builder: (context, state, child) {
    //             return ShellScreen(
    //                 key: state.pageKey,
    //                 child: child
    //             );
    //           },
    //           // navigatorKey: _shellNavigatorKey
    //           routes: [
    //             GoRoute(
    //                 path: "home",
    //                 pageBuilder: (context, state) {
    //                   return CustomTransitionPage(
    //                     transitionDuration: const Duration(milliseconds: 450),
    //                     key: state.pageKey,
    //                     child: HomeScreen(),
    //                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //                       // Change the opacity of the screen using a Curve based on the the animation's
    //                       // value
    //                       return SlideTransition(
    //                         position: Tween<Offset>(
    //                           begin: const Offset(1, 0),
    //                           end: Offset.zero,
    //                         ).animate(animation),
    //                         child: child,
    //                       );
    //                     },
    //                   );
    //                 }
    //             ),
    //             GoRoute(
    //               path: "search",
    //               builder: (context, state) => const SearchScreen(),
    //             ),
    //             GoRoute(
    //               path: "cart",
    //               builder: (context, state) => const CartScreen(),
    //             ),
    //             GoRoute(
    //               path: "profile",
    //               builder: (context, state) => const ProfileScreen(),
    //             )
    //           ]
    //         ),
    //
    //       ],
    //     ),
    //   ],
    // );

    return ScreenUtilInit(
            builder: (context, child) => MaterialApp(
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(
                        color: Colors.red
                    )
                )
            ),
            home: OnboardingScreen(),
            // MaterialApp.router(
            //   routerConfig: _router,
            //   title: "Go router",
            //   debugShowCheckedModeBanner: false,
            // ),
              debugShowCheckedModeBanner: false,

          )
    );
  }
}