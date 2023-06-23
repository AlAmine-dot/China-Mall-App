import 'package:flutter/cupertino.dart';
import 'package:lumia_app/feature_store/data/local/entities/product_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../exceptions/store_database_exception.dart';


abstract class ProductDao{

  Future<void> addProducts(List<ProductEntity> productsList);

  Future<void> updateProduct(ProductEntity product);

  Future<void> deleteProduct(ProductEntity product);

  Future<List<ProductEntity>> getProducts({required int limit, required int skip});

  Future<List<ProductEntity>> searchProductsByName({required String queryString});

  Future<List<ProductEntity>> getProductsByCategory({required String categoryName});

  Future<ProductEntity> getSingleProductById(int productId);

}

class ProductDaoImpl extends ProductDao{
  final sql.Database database;

  ProductDaoImpl(this.database);

  @override
  Future<List<ProductEntity>> getProducts({required int limit, required int skip}) async {
    try {
      final results = await database.query(
        'products',
        limit: limit,
        offset: skip,
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
          isProductIntoCart: result['isIntoCart'] == 1 ? true : false
        );
      }).toList();
    } catch (error) {
      // Handle the error here, e.g., by displaying an error message or throwing a custom exception.
      debugPrint('An error occurred while retrieving products: $error');
      throw StoreDatabaseException('Error retrieving products');
    }
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
          isProductIntoCart: result['isIntoCart'] == 1 ? true : false
        );
      }).toList();
    } catch (error) {
      // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la récupération des produits par catégorie : $error');
      throw StoreDatabaseException('Erreur lors de la récupération des produits par catégorie');
    }
  }


  @override
  Future<ProductEntity> getSingleProductById(int productId) async {
    try {
      final results = await database.query(
        'products',
        where: 'id = ?',
        whereArgs: [productId],
        limit: 1,
      );

      if (results.isNotEmpty) {
        final result = results.first;
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
          isProductIntoCart: result['isIntoCart'] == 1 ? true : false
        );
      } else {
        throw Exception('Product not found');
      }
    } catch (error) {
      // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la récupération du produit par ID : $error');
      throw StoreDatabaseException('Erreur lors de la récupération du produit par ID');
    }
  }


  @override
  Future<List<ProductEntity>> searchProductsByName({required String queryString}) async {
    try {
      final results = await database.query(
        'products',
        where: 'title LIKE ? OR description LIKE ? OR category LIKE ? OR brand LIKE ?',
        whereArgs: [
          '%$queryString%',
          '%$queryString%',
          '%$queryString%',
          '%$queryString%',
        ],
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
          isProductIntoCart: result['isIntoCart'] == 1 ? true : false

        );
      }).toList();
    } catch (error) {
      // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la recherche des produits par nom : $error');
      throw StoreDatabaseException('Erreur lors de la recherche des produits par nom');
    }
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
            'isIntoCart': product.isProductIntoCart ? 1 : 0
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
  Future<void> deleteProduct(ProductEntity product) async {
    try {
      await database.delete(
        'products',
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (error) {
      // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la suppression du produit : $error');
      throw StoreDatabaseException('Erreur lors de la suppression du produit');
    }
  }


  @override
  Future<void> updateProduct(ProductEntity product) async {
    try {
      await database.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (error) {
      // Gérer l'erreur ici, par exemple, en affichant un message d'erreur ou en lançant une nouvelle exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la mise à jour du produit : $error');
      throw StoreDatabaseException('Erreur lors de la mise à jour du produit');
    }
  }

  
}