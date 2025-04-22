import 'package:sqflite/sqflite.dart';
import 'package:team_31_health_app/data/database/database_attributes/data_model.dart';

abstract class DatabaseService<T extends DataModel> {
  DatabaseService({required this.database});
  final Database database;

  bool running = false;

  /// This function inserts a [DataModel] that 
  /// implements the Map function.
  /// Throws an [Exception] if any part of this fails.
  Future<T> insert(T data);
  
  /// This function gets all the rows of the [DataModel] 
  /// for this table and returns the list of objects.
  /// Throws an [Exception] if any part of this fails.
  Future<List<T>> get();
}