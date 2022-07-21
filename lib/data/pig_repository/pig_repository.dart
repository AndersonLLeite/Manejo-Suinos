import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../data_helper/data_helper.dart';

class PigRepository extends ChangeNotifier {
  String tablePigs =
      "CREATE TABLE tablepigs (name TEXT PRIMARY KEY, imageUrl TEXT, age INTEGER, weight REAL, gpd REAL, gender TEXT, finality TEXT, obtained TEXT, motherName TEXT, fatherName TEXT, status TEXT)";

  PigRepository._privateConstructor();
  static final PigRepository instance = PigRepository._privateConstructor();

  Future<List<PigEntity>> getActivePigs() async {
    Database db = await DataHelper.instance.database;
    var pigs = await db.rawQuery('''
    SELECT * FROM tablepigs
    WHERE status=?
    ''', ['ACTIVE']);
    List<PigEntity> pigsList =
        pigs.isNotEmpty ? pigs.map((c) => PigEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return pigsList;
  }

  Future<List<PigEntity>> getArchivedPigs() async {
    Database db = await DataHelper.instance.database;
    var pigs = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE status=?
      ''', ['ARCHIVED']);
    List<PigEntity> pigsList =
        pigs.isNotEmpty ? pigs.map((c) => PigEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return pigsList;
  }

  Future<List<PigEntity>> getMatrix() async {
    Database db = await DataHelper.instance.database;
    var matrix = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE gender=? 
      ''', ['FEMALE']);
    List<PigEntity> listMatrix = matrix.isNotEmpty
        ? matrix.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listMatrix;
  }

  Future<List<PigEntity>> getBreeder() async {
    Database db = await DataHelper.instance.database;
    var breeder = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE gender=? 
      ''', ['MALE']);
    List<PigEntity> listBreeder = breeder.isNotEmpty
        ? breeder.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listBreeder;
  }

  Future<List<PigEntity>> getFatted() async {
    Database db = await DataHelper.instance.database;
    var fatted = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE finality=? 
      ''', ['FATTED']);
    List<PigEntity> listFatted = fatted.isNotEmpty
        ? fatted.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listFatted;
  }

  Future addPig(PigEntity pigEntity) async {
    Database db = await DataHelper.instance.database;
    await db.insert('tablepigs', pigEntity.toMap());
    notifyListeners();
  }

  Future removePig(String name) async {
    Database db = await DataHelper.instance.database;
    await db.delete('tablepigs', where: 'name= ?', whereArgs: [name]);
    notifyListeners();
  }

  Future updatePig(PigEntity pigEntity) async {
    Database db = await DataHelper.instance.database;
    await db.update('tablepigs', pigEntity.toMap(),
        where: "name = ?", whereArgs: [pigEntity.name]);
    notifyListeners();
  }
}
