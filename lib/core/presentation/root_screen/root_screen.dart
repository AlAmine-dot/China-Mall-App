import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumia_app/core/commons/theme/app_colors.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_event.dart';
import 'package:lumia_app/core/presentation/root_screen/bloc/root_state.dart';

import 'bloc/root_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RootBloc>(
      lazy: false,
      create: (_) => RootBloc(),
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {

          final rootBloc = context.read<RootBloc>();
          void onTap(int index) {
            rootBloc.add(ChangeRoute(index));
          }

          return Scaffold(
            body: IndexedStack(
              index: state.routeIndex,
              children: state.navbarItems.map((e) => e.screen).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.smoothChinaRed,
              unselectedItemColor: Colors.black.withOpacity(.5),
              showUnselectedLabels: true,
              elevation: 500,
              currentIndex: state.routeIndex,
              onTap: onTap,
              items: state.navbarItems.map((item) =>
                  BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.title),
                ).toList(),
            ),
          );
        }
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    return 0;
    // final GoRouter route = GoRouter.of(context);
    // final String location = route.location;
    // if (location.startsWith('/home')) {
    //   return 0;
    // }
    // if (location.startsWith('/search')) {
    //   return 1;
    // }
    // if (location.startsWith('/profile')) {
    //   return 2;
    // }
    // return 0;
  }


}
