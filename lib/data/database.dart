import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        timestamp TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await instance.database;
    return await db.query('notes');
  }

  Future<int> addNewNote({
    required String title,
    required String content,
    required String timestamp,
  }) async {
    final db = await instance.database;
    return await db.insert('notes', {
      'title': title,
      'content': content,
      'timestamp': timestamp,
    });
  }

  Future<int> updateNote({
    required int id,
    required String title,
    required String content,
    required String timestamp,
  }) async {
    final db = await instance.database;
    return await db.update(
        'notes',
        {
          'title': title,
          'content': content,
          'timestamp': timestamp,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<int> deleteNote({
    required int id,
  }) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
