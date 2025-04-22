import 'package:sqflite/sqflite.dart';

abstract class DatabaseService<T extends Object> {
  DatabaseService({required this.database});
  final Database database;

  bool running = false;

  Future<T> insert(T data);
  
  Future<List<T>> get();
}