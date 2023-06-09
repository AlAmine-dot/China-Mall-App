import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class ChinamallDatabase {
  static const _databaseName = 'chinamall.db';
  static const _databaseVersion = 1;

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

    // // Stocker l'instance de la base de données pour y accéder ultérieurement
    // DatabaseRepository().setDatabase(database);
  }

  Future<void> createTables(sql.Database database) async {
    // Créer les tables nécessaires dans la base de données
    await database.execute('''
      CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    // Autres tables si nécessaire
  }
}
