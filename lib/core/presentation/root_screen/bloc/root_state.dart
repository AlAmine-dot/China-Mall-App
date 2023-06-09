import 'package:flutter/material.dart';
import 'package:lumia_app/feature_store/presentation/home_screen/home_screen.dart';

import '../../../../feature_store/presentation/cart_screen/cart_screen.dart';
import '../../../../feature_store/presentation/profile_screen/profile_screen.dart';
import '../../../../feature_store/presentation/search_screen/search_screen.dart';
import '../../../domain/models/app_navbar_item.dart';

class RootState {
  final int routeIndex;
  final List<AppNavbarItem> navbarItems;

  const RootState({
    this.routeIndex = 0,
    this.navbarItems = const [
      AppNavbarItem(HomeScreen(), Icons.home, "Home"),
      AppNavbarItem(SearchScreen(), Icons.search, "Search"),
      AppNavbarItem(CartScreen(), Icons.shopping_cart, "Cart"),
      AppNavbarItem(ProfileScreen(), Icons.person, "Log in"),
    ],
  });

  RootState copyWith({
    int? routeIndex,
    List<AppNavbarItem>? navbarItems,
  }) {
    return RootState(
      routeIndex: routeIndex ?? this.routeIndex,
      navbarItems: navbarItems ?? this.navbarItems,
    );
  }
}
