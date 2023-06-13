import 'package:flutter/cupertino.dart';
import 'package:lumia_app/feature_store/data/local/entities/category_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../exceptions/store_database_exception.dart';

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

    try{
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

    } catch (error) {
    // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
    debugPrint('Une erreur s\'est produite lors de l\'ajout des catégories : $error');
    throw StoreDatabaseException('Erreur lors de l\'ajout des catégories');
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try{
      final results = await database.query('categories');
      return results
          .map((result) => CategoryEntity(
          categoryName: result['categoryName'] as String,
          categoryIcon: stringToIconData(result['categoryIcon'] as String)))
          .toList();
    } catch (error) {
    // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
    debugPrint('Une erreur s\'est produite lors de la récupération des catégories : $error');
    throw StoreDatabaseException('Erreur lors de la récupération des catégories');
    }
  }

  @override
  Future<CategoryEntity?> getCategoryByName(String categoryName) async {

    try{

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

    } catch (error) {
    // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
    debugPrint('Une erreur s\'est produite la récupération des catégories : $error');
    throw StoreDatabaseException('Erreur la récupération des catégories');
    }
  }

  @override
  Future<void> deleteAllCategories() async {
    try{
      await database.delete('categories');
    } catch (error) {
    // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
    debugPrint('Une erreur s\'est produite lors de la suppression des catégories : $error');
    throw StoreDatabaseException('Erreur lors de la suppression des catégories');
    }
  }

}

String iconDataToString(IconData iconData) {
  return String.fromCharCode(iconData.codePoint);
}

IconData stringToIconData(String iconString) {
  int codePoint = iconString.codeUnitAt(0);
  return IconData(codePoint, fontFamily: 'MaterialIcons');
}
