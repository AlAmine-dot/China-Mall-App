import 'package:flutter/cupertino.dart';
import 'package:lumia_app/feature_store/data/local/entities/product_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import '../../exceptions/store_database_exception.dart';


abstract class ProductDao{

  Future<void> addProducts(List<ProductEntity> productsList);

  Future<void> updateProduct(ProductEntity);

  Future<void> deleteProduct(ProductEntity);

  Future<List<ProductEntity>> getProducts({required int limit, required int skip});

  Future<List<ProductEntity>> searchProductsByName({required String queryString, required int limit, required int skip});

  Future<List<ProductEntity>> getProductsByCategory({required String categoryName});

  Future<ProductEntity> getSingleProductById(int productId);

}

class ProductDaoImpl extends ProductDao{
  final sql.Database database;

  ProductDaoImpl(this.database);
  
  @override
  Future<List<ProductEntity>> getProducts({required int limit, required int skip}) {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory({
    required String categoryName,
  }) async {
    try{
      final results = await database.query(
        'products',
        where: 'category = ?',
        whereArgs: [categoryName],
      );

      return results.map((result) {
        final imagesString = result['images'] as String;
        final imagesList = imagesString.split(',');
        return ProductEntity(
          id: result['id'] as int,
          title: result['title'] as String,
          description: result['description'] as String,
          price: result['price'] as int,
          nondiscountPrice: result['nondiscountPrice'] as int,
          discountPercentage: result['discountPercentage'] as double,
          rating: result['rating'] as double,
          stock: result['stock'] as int,
          brand: result['brand'] as String,
          category: result['category'] as String,
          thumbnail: result['thumbnail'] as String,
          images: imagesList,
        );
      }).toList();
    } catch (error) {
      // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la récupération des produits par catégorie : $error');
      throw StoreDatabaseException('Erreur lors de la récupération des produits par catégorie');
    }
  }


  @override
  Future<ProductEntity> getSingleProductById(int productId) {
    // TODO: implement getSingleProductById
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> searchProductsByName({required String queryString, required int limit, required int skip}) {
    // TODO: implement searchProductsByName
    throw UnimplementedError();
  }

  @override
  Future<void> addProducts(List<ProductEntity> productsList) async {

    try{

      final batch = database.batch();

      for (final product in productsList) {
        batch.insert(
          'products',
          {
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'nondiscountPrice': product.nondiscountPrice,
            'discountPercentage': product.discountPercentage,
            'rating': product.rating,
            'stock': product.stock,
            'brand': product.brand,
            'category': product.category,
            'thumbnail': product.thumbnail,
            'images': product.images.join(','),
          },
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);

    } catch (error) {
    // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
    debugPrint('Une erreur s\'est produite lors de l\'ajout des produits : $error');
    throw StoreDatabaseException('Erreur lors de l\'ajout des produits');
    }

  }


  @override
  Future<void> deleteProduct(ProductEntity) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductEntity) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
  
}