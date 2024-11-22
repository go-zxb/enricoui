import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

const defaultSql = 'CREATE TABLE IF NOT EXISTS user ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
    'uuid TEXT,'
    'name TEXT,'
    'age INTEGER'
    ')';

class ESQLite {
  ESQLite({
    required this.uuid,
    this.sql = defaultSql,
    this.databaseName = "default.db",
    this.tableName = "user",
  }) {
    if (!databaseName.contains(".db")) {
      databaseName += ".db";
    }
    init();
  }

  String uuid;
  String sql;
  String databaseName;
  Database? _db;
  String tableName;

  Future<String> xGetDatabasesPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> init() async {
    final String tempDir = await xGetDatabasesPath();
    _db = sqlite3.open("$tempDir/$databaseName");
    await _createTables();
    print("加载SQLite3数据库完成");
  }

  Future<void> _createTables() async {
    final result = _db!.select(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    if (result.isEmpty) {
      _db!.execute(sql);
    }
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    data['uuid'] = uuid;
    final columns = data.keys.join(', ');
    final placeholders = List.filled(data.length, '?').join(', ');
    final values = data.values.toList();
    final queryStr = 'INSERT INTO $tableName ($columns) VALUES ($placeholders)';
    try {
      _db!.execute(queryStr, values);
      return _db!.lastInsertRowId;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  Future<int> updateData(
      Map<String, dynamic> data, Map<String, dynamic> where) async {
    final columns = data.keys.map((key) => '$key = ?').join(', ');
    final placeholders = where.keys.map((key) => '$key = ?').join(' AND ');
    final values = [...data.values, ...where.values];
    final queryStr = 'UPDATE $tableName SET $columns WHERE $placeholders';
    try {
      _db!.execute(queryStr, values);
      return _db!.updatedRows;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  Future<int> delete({Map<String, dynamic>? where}) async {
    String whereClause = where != null && where.isNotEmpty
        ? ' WHERE ${where.keys.map((key) => '$key = ?').join(' AND ')}'
        : '';
    final values =
        where != null && where.isNotEmpty ? where.values.toList() : [];
    final queryStr = 'DELETE FROM $tableName$whereClause';
    try {
      _db!.execute(queryStr, values);
      return _db!.updatedRows;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  Future<List<Map<String, Object?>>> query(
      {Map<String, dynamic>? where}) async {
    String whereClause = where != null && where.isNotEmpty
        ? ' WHERE ${where.keys.map((key) => '$key = ?').join(' AND ')}'
        : '';
    final values =
        where != null && where.isNotEmpty ? where.values.toList() : [];
    final result = _db!.select(
        'SELECT * FROM $tableName$whereClause ORDER BY ID DESC', values);
    return result.toList();
  }

  Future<List<Map<String, Object?>>> queryPage(
      {Map<String, dynamic>? where,
      int limit = 20,
      required int pageNumber}) async {
    final offset = calculateOffset(pageNumber, limit);
    String whereClause = where != null && where.isNotEmpty
        ? ' WHERE ${where.keys.map((key) => '$key = ?').join(' AND ')}'
        : '';
    final values =
        where != null && where.isNotEmpty ? where.values.toList() : [];
    final result = _db!.select(
        'SELECT * FROM $tableName$whereClause ORDER BY ID DESC LIMIT ? OFFSET ?',
        [...values, limit, offset]);
    return result.toList();
  }

  void deleteTable() {
    _db!.execute("DROP TABLE IF EXISTS $tableName");
  }

  void closeDatabase() {
    if (_db != null) {
      _db!.dispose();
      _db = null;
    }
  }

  int calculateOffset(int pageNumber, int limit) {
    if (pageNumber <= 0) {
      return 0;
    }
    return (pageNumber - 1) * limit;
  }
}
