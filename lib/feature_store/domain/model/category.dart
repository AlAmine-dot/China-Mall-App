import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String categoryName;
  final IconData categoryIcon;

  const Category({required this.categoryName, required this.categoryIcon});

  factory Category.toCategoryModel(String dto) {
    IconData iconData;

    switch (dto) {
      case "smartphones":
        iconData = Icons.smartphone;
        break;
      case "laptops":
        iconData = Icons.laptop;
        break;
      case "fragrances":
        iconData = FontAwesomeIcons.bottleDroplet;
        break;
      case "skincare":
        iconData = FontAwesomeIcons.faceKiss;
        break;
      case "groceries":
        iconData = FontAwesomeIcons.bagShopping;
        break;
      case "furniture":
        iconData = FontAwesomeIcons.couch;
      case "tops":
        iconData = FontAwesomeIcons.shirt;
        break;
      case "womens-dresses":
        iconData = FontAwesomeIcons.personDress;
        break;
      case "womens-shoes":
        iconData = FontAwesomeIcons.shoePrints;
        break;
      case "mens-shirt":
        iconData = FontAwesomeIcons.shirt;
        break;
      case "mens-shoes":
        iconData = FontAwesomeIcons.shoePrints;
        break;
      case "mens-watches":
        iconData = Icons.watch;
        break;
      case "womens-watches":
        iconData = Icons.watch;
        break;
      case "womens-bags":
        iconData = Icons.shopping_bag;
        break;
      case "womens-jewellery":
        iconData = FontAwesomeIcons.ring;
        break;
      case "sunglasses":
        iconData = FontAwesomeIcons.glasses;
        break;
      case "automotive":
        iconData = Icons.car_rental;
        break;
      case "motorcycle":
        iconData = Icons.motorcycle;
        break;
      case "lighting":
        iconData = Icons.light;
        break;
      default:
        iconData = Icons.category;
        break;
    }

    return Category(
      categoryName: dto,
      categoryIcon: iconData,
    );
  }

  @override
  String toString() {
    return 'Category{categoryName: $categoryName, categoryIcon: $categoryIcon}';
  }
}
