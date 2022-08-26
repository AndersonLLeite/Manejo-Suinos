import 'dart:io';
import 'package:manejo_suinos/data/data_helper/create_db_initial.dart';
import 'package:manejo_suinos/data/vaccine_repository/vaccine_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../event_repository/event_repository.dart';

class DataHelper {
  static Database? _database;
  //TODO: Change this After
  final CreateDbInitial _createDbInitial = CreateDbInitial();

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
    await db.execute(EventRepository.instance.tableEvents);
    await db.execute(VaccineRepository.instance.tableVaccines);
    await _createDbInitial.createInitialData();
  }
}
