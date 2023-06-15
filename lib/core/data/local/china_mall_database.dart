import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../../../feature_store/data/local/dao/category_dao.dart';
import '../../../feature_store/data/local/dao/product_dao.dart';

class ChinamallDatabase {

  late CategoryDao categoryDao;
  late ProductDao productDao;

  static const _databaseName = 'chinamall.db';
  static const _databaseVersion = 5;

  Future<void> createDatabase() async {
    final databasePath = await sql.getDatabasesPath();
    final String pathToDatabase = path.join(databasePath, _databaseName);

    final database = await sql.openDatabase(
      pathToDatabase,
      version: _databaseVersion,
      onCreate: (db, version) async {
        // Créer les tables et effectuer les opérations nécessaires lors de la création de la base de données
        await createTables(db);
        // Autres opérations initiales si nécessaire
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Effectuer les opérations nécessaires lors de la mise à niveau de la base de données (par exemple, modifier la structure des tables)
        // Assurez-vous de gérer correctement les migrations de données si nécessaire
      },
    );

    // // Stocker les instances de chaque dao pour y accéder ultérieurement
    categoryDao = CategoryDaoImpl(database);
    productDao = ProductDaoImpl(database);
  }

  Future<void> createTables(sql.Database database) async {
    // Créer les tables nécessaires dans la base de données
    await database.execute('''
        CREATE TABLE IF NOT EXISTS categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          categoryName TEXT UNIQUE,
          categoryIcon TEXT
        )
    ''');
    await database.execute('''
        CREATE TABLE IF NOT EXISTS products (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          title TEXT,
          description TEXT,
          price INTEGER,
          nondiscountPrice INTEGER,
          discountPercentage REAL,
          rating REAL,
          stock INTEGER,
          brand TEXT,
          category TEXT,
          thumbnail TEXT,
          images TEXT
        )
    ''');
    // Autres tables si nécessaire
  }
}
