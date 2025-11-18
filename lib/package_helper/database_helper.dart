import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'book.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookmarks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            product_id INTEGER NOT NULL,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT,
            rating REAL,
            rating_count INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertBookmark(Map<String, dynamic> item) async {
    final client = await db;
    item.remove('id');
    return await client.insert('bookmarks', item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final client = await db;
    return client.query('bookmarks', orderBy: 'id ASC');
  }

  Future<int> deleteBookmarkByProductId(int productId) async {
    final client = await db;
    return await client.delete('bookmarks', where: 'product_id = ?', whereArgs: [productId]);
  }

  Future<bool> isBookmarked(int productId) async {
    final client = await db;
    final res = await client.query('bookmarks', where: 'product_id = ?', whereArgs: [productId]);
    return res.isNotEmpty;
  }

  Future<void> clearAllBookmarks() async {
    final client = await db;
    await client.delete('bookmarks');
  }
}