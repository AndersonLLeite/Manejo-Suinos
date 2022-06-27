import 'dart:io';
import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/entities/pig/pig_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataHelper extends ChangeNotifier {
  List<PigEntity> _listPigs = [];

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
    await db.execute('''
      CREATE TABLE tablepigs(
          name TEXT PRIMARY KEY,
          age INTEGER,
          weight REAL,
          imageUrl TEXT,
          breed TEXT,
          obtained TEXT,
          gender TEXT,
          motherName TEXT,
          fatherName TEXT
      )
      ''');
  }

  Future<List<PigEntity>> getPigsEntity() async {
    Database db = await instance.database;
    var pigs = await db.query('tablepigs', orderBy: 'name');
    List<PigEntity> pigsList =
        pigs.isNotEmpty ? pigs.map((c) => PigEntity.fromMap(c)).toList() : [];
    _listPigs = pigsList;
    return _listPigs;
  }

  Future add(PigEntity pigEntity) async {
    Database db = await instance.database;
    await db.insert('tablepigs', pigEntity.toMap());
    notifyListeners();
  }

  Future remove(String name) async {
    Database db = await instance.database;
    await db.delete('tablepigs', where: 'name= ?', whereArgs: [name]);
    _reloadList();
  }

  Future update(PigEntity pigEntity) async {
    Database db = await instance.database;
    await db.update('tablepigs', pigEntity.toMap(),
        where: "name = ?", whereArgs: [pigEntity.name]);
    _reloadList();
  }

  Future _reloadList() async {
    _listPigs = await getPigsEntity();
    notifyListeners();
  }
}
