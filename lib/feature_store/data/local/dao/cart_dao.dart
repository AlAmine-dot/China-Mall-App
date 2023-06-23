import 'package:flutter/cupertino.dart';
import 'package:lumia_app/feature_store/data/local/entities/cart_item_entity.dart';
import 'package:lumia_app/feature_store/data/local/entities/product_entity.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../exceptions/store_database_exception.dart';


abstract class CartDao{

  Future<void> addToCart(ProductEntity product);

  Future<void> removeFromCart(ProductEntity product);

  Future<void> updateQuantity(ProductEntity product,int newQuantity);

  Future<List<CartItemEntity>> getCart();

  Future<bool> isProductIntoCart(int productId);

  Future<void> clearCart();

}

class CartDaoImpl extends CartDao{
  final sql.Database database;

  CartDaoImpl(this.database);

  @override
  Future<void> addToCart(ProductEntity product) async {
    try {
      // Vérifier si le produit est déjà dans le panier
      bool isProductInCart = await isProductIntoCart(product.id);

      if (!isProductInCart){
        // Le produit n'est pas encore dans le panier, vous pouvez l'ajouter
        await database.insert(
          'cart',
          {
            'productId': product.id,
            'quantity': 1,
          },
          conflictAlgorithm: sql.ConflictAlgorithm.ignore,
        );
      }
    } catch (error) {
      // Handle the error here, e.g., by displaying an error message or throwing a custom exception.
      debugPrint('An error occurred while retrieving cart: $error');
      throw StoreDatabaseException('Error retrieving cart');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await database.delete('cart');
    } catch (error) {
      // Gérer l'erreur ici, par exemple en affichant un message d'erreur ou en lançant une exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la suppression du panier : $error');
      throw StoreDatabaseException('Erreur lors de la suppression du panier');
    }
  }


  @override
  Future<List<CartItemEntity>> getCart() async {
    try {
      final List<Map<String, dynamic>> cartItems = await database.query('cart');

      return cartItems.map((item) => CartItemEntity.fromMap(item)).toList();
    } catch (error) {
      // Gérer l'erreur ici, par exemple en affichant un message d'erreur ou en lançant une exception personnalisée.
      debugPrint('Une erreur s\'est produite lors de la récupération du panier : $error');
      throw StoreDatabaseException('Erreur lors de la récupération du panier');
    }
  }

  @override
  Future<bool> isProductIntoCart(int productId) async {
    try {
      final countResult = await database.rawQuery('''
      SELECT COUNT(*) AS count
      FROM cart
      WHERE productId = ?
    ''', [productId]);

      final count = countResult.first['count'] as int;
      return count > 0;
    } catch (error) {
      debugPrint('An error occurred while checking if product is in cart: $error');
      throw StoreDatabaseException('Error checking if product is in cart');
    }
  }


  @override
  Future<void> removeFromCart(ProductEntity product) async {
    try {
      await database.delete(
        'cart',
        where: 'productId = ?',
        whereArgs: [product.id],
      );
    } catch (error) {
      debugPrint('An error occurred while removing product from cart: $error');
      throw StoreDatabaseException('Error removing product from cart');
    }
  }


  @override
  Future<void> updateQuantity(ProductEntity product, int newQuantity) async {
    try {
      await database.update(
        'cart',
        {'quantity': newQuantity},
        where: 'productId = ?',
        whereArgs: [product.id],
      );
    } catch (error) {
      debugPrint('An error occurred while updating quantity in cart: $error');
      throw StoreDatabaseException('Error updating quantity in cart');
    }
  }


  
}