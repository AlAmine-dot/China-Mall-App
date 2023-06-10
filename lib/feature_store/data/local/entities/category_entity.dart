import 'package:flutter/material.dart';

import '../../../domain/model/category.dart';

class CategoryEntity {
  final String categoryName;
  final IconData categoryIcon;

  const CategoryEntity({required this.categoryName, required this.categoryIcon});

  factory CategoryEntity.toCategoryEntity(Category model) => CategoryEntity(categoryName: model.categoryName, categoryIcon: model.categoryIcon);

}