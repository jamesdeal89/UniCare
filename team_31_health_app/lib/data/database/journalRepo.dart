import 'package:sqflite/sqflite.dart';
import 'package:team_31_health_app/data/database/databaseService.dart';
import 'package:team_31_health_app/data/database_fields/journalEntry.dart';

class JournalRepo extends DatabaseService<JournalEntry> {
  JournalRepo({required super.database});

  static const String tableName = 'journal_entries';

  static const int columnId = 0;
  static const String columnTitle = 'title';
  static const String columnDate = 'date';
  static const String columnDescription = 'description';
  static const String columnGive = 'give';
  static const String columnTakeNotice = 'takeNotice';
  static const String columnKeepLearning = 'keepLearning';
  static const String columnBeActive = 'beActive';
  static const String columnConnect = 'connect';

  @override
  Future<JournalEntry> insert(JournalEntry data) async {
    running = true;
    try {
      await database.insert(
        tableName,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      running = false;
      return data;
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
  }

  @override
  Future<List<JournalEntry>> get() async {
    running = true;
    try {
      final List<Map<String, dynamic>> maps = await database.query(tableName);
      running = false;
      return List.generate(maps.length, (i) {
        return JournalEntry.fromMap(maps[i]);
      });
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
  }

  Future<JournalEntry> update(JournalEntry data) async {
    running = true;
    try {
      await database.update(
        tableName,
        data.toMap(),
        where: 'id = ?',
        whereArgs: [
          data.id
        ],
      );
      running = false;
      return data;
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    running = true;
    try {
      await database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [
          id
        ],
      );
      running = false;
    } on Exception catch (_) {
      running = false;
      rethrow;
    }
  }

  Future<int> count(int id) async {
    String queryCol = "";
    switch (id) {
      case 0:
        queryCol = columnGive;
        break;
      case 1:
        queryCol = columnTakeNotice;
        break;
      case 2:
        queryCol = columnKeepLearning;
        break;
      case 3:
        queryCol = columnBeActive;
        break;
      case 4:
        queryCol = columnConnect;
        break;
      default:
    }
    try {
      List<Map<String, Object?>> results = await database.rawQuery('SELECT SUM($queryCol) AS Result FROM $tableName');
      print(results[0]);
      final result = int.tryParse(results[0]["Result"].toString());
      if (result == null) {
        return 0;
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }
}
