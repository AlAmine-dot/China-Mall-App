import 'package:flutter/cupertino.dart';
import 'package:lumia_app/feature_store/data/local/entities/category_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;

abstract class CategoryDao{

  Future<List<CategoryEntity>> getCategories();

  addCategories(List<CategoryEntity> categoryList);

  deleteAllCategories();

  Future<CategoryEntity?> getCategoryByName(String categoryName);

}

class CategoryDaoImpl extends CategoryDao {
  final sql.Database database;

  CategoryDaoImpl(this.database);

  @override
  Future<void> addCategories(List<CategoryEntity> categoryList) async {
    final batch = database.batch();

    for (final category in categoryList) {
      batch.insert(
        'categories',
        {
          'categoryName': category.categoryName,
          'categoryIcon': iconDataToString(category.categoryIcon),
        },
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
      final results = await database.query('categories');
      return results
          .map((result) => CategoryEntity(
          categoryName: result['categoryName'] as String,
          categoryIcon: stringToIconData(result['categoryIcon'] as String)))
          .toList();
  }

  @override
  Future<CategoryEntity?> getCategoryByName(String categoryName) async {
    final results = await database.query('categories',
        where: 'categoryName = ?',
        whereArgs: [categoryName],
        limit: 1);

    if (results.isNotEmpty) {
      final result = results.first;
      return CategoryEntity(
        categoryName: result['categoryName'] as String,
        categoryIcon: stringToIconData(result['categoryIcon'] as String),
      );
    }

    return null;
  }

  @override
  Future<void> deleteAllCategories() async {
    await database.delete('categories');
  }

}

String iconDataToString(IconData iconData) {
  return String.fromCharCode(iconData.codePoint);
}

IconData stringToIconData(String iconString) {
  int codePoint = iconString.codeUnitAt(0);
  return IconData(codePoint, fontFamily: 'MaterialIcons');
}
