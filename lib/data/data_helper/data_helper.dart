import 'dart:io';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataHelper {
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  DataHelper._privateConstructor();
  static final DataHelper instance = DataHelper._privateConstructor();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'pigsdata.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(PigRepository.instance.tablePigs);
    await db.execute(WeighingRepository.instance.tableWeighing);
  }
}
