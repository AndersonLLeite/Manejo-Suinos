import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/model/entities/pig/pig_entity.dart';
import '../data_helper/data_helper.dart';

class PigRepository extends ChangeNotifier {
  String tablePigs =
      "CREATE TABLE tablepigs (name TEXT PRIMARY KEY, imageUrl TEXT, age INTEGER, weight REAL, gpd REAL, gender TEXT, finality TEXT, obtained TEXT, motherName TEXT, fatherName TEXT, status TEXT, buyValue REAl, sellValue REAL, isPregnant INTEGER, birthday INTEGER, pigstyName TEXT)";

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
      WHERE finality=? 
      ''', ['Matriz']);
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
      WHERE finality=? 
      ''', ['Reprodutor']);
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

  Future<PigEntity> getPigByName(String name) async {
    Database db = await DataHelper.instance.database;
    var pig = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE name=? 
      ''', [name]);
    List<PigEntity> listPig =
        pig.isNotEmpty ? pig.map((c) => PigEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return listPig[0];
  }

  Future<int> getNumberOfChildren(String name) async {
    Database db = await DataHelper.instance.database;
    var sons = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE fatherName=? OR motherName=?
      ''', [name, name]);
    List<PigEntity> listSons =
        sons.isNotEmpty ? sons.map((c) => PigEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return listSons.length;
  }

  Future<double> getValueChildrenSells(String name) async {
    Database db = await DataHelper.instance.database;
    var soma = await db.rawQuery('''
      SELECT SUM(sellValue) FROM tablepigs
      WHERE fatherName=? OR motherName=? AND status=?
      ''', [name, name, 'ARCHIVED']);
    Object? somaSells = soma[0]['SUM(sell)'];
    notifyListeners();
    return somaSells != null ? double.parse(somaSells.toString()) : 0;
  }

  Future<double> getValueEstimateChildrenActive(String name) async {
    Database db = await DataHelper.instance.database;
    var soma = await db.rawQuery('''
      SELECT SUM(weight) FROM tablepigs
      WHERE fatherName=? OR motherName=? AND status=?
      ''', [name, name, 'ACTIVE']);
    Object? sum = soma[0]['SUM(weight)'];
    notifyListeners();
    return sum != null ? double.parse(sum.toString()) : 0;
  }

  Future<int> getIPigIsPregnantByName(String name) async {
    Database db = await DataHelper.instance.database;
    var isPregnant = await db.rawQuery('''
      SELECT isPregnant FROM tablepigs
      WHERE name=?
      ''', [name]);
    List<PigEntity> listIsPregnant = isPregnant.isNotEmpty
        ? isPregnant.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listIsPregnant[0].isPregnant;
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

  Future<List<PigEntity>> getPigsWithAgeLessThan(
      int firstApplicationLifeDays) async {
    Database db = await DataHelper.instance.database;
    var pigs = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE age<=? 
      ''', [firstApplicationLifeDays]);
    List<PigEntity> listpigs =
        pigs.isNotEmpty ? pigs.map((c) => PigEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return listpigs;
  }

  Future<List<PigEntity>> getPigsWithAgeLessThanStage(
      int firstApplicationLifeDays, String finality) async {
    Database db = await DataHelper.instance.database;
    var pigs = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE age <=? AND finality=?
      ''', [firstApplicationLifeDays, finality]);
    List<PigEntity> listpigs =
        pigs.isNotEmpty ? pigs.map((c) => PigEntity.fromMap(c)).toList() : [];

    notifyListeners();
    return listpigs;
  }

  Future<DateTime> getPigBirth(String name) async {
    Database db = await DataHelper.instance.database;
    var pig = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE name=?
      ''', [name]);
    List<PigEntity> listpig =
        pig.isNotEmpty ? pig.map((c) => PigEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return listpig[0].birthday;
  }

  Future<void> attPigsAge(DateTime today) async {
    var pigAtive = await getActivePigs();
    for (final pig in pigAtive) {
      PigEntity updatedPig =
          pig.copyWith(age: today.difference(pig.birthday).inDays);
      updatePig(updatedPig);
    }
    notifyListeners();
  }

  Future<List<PigEntity>> getPigsByFatherName(String name) async {
    Database db = await DataHelper.instance.database;
    var isFatherName = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE fatherName=?
      ''', [name]);
    List<PigEntity> listIsFatherName = isFatherName.isNotEmpty
        ? isFatherName.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listIsFatherName;
  }

  Future<List<PigEntity>> getPigsByMotherName(String name) async {
    Database db = await DataHelper.instance.database;
    var isMotherName = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE motherName=?
      ''', [name]);
    List<PigEntity> listIsMotherName = isMotherName.isNotEmpty
        ? isMotherName.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listIsMotherName;
  }

  Future<bool> havePigWithThisName(String name) async {
    Database db = await DataHelper.instance.database;
    var pig = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE name=?
      ''', [name]);
    if (pig.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<PigEntity>> getMatrixByPigstyName(String name) async {
    Database db = await DataHelper.instance.database;
    var matrix = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE finality=? AND pigstyName=?
      ''', ["Matriz", name]);
    List<PigEntity> matrixSelected = matrix.isNotEmpty
        ? matrix.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return matrixSelected;
  }

  Future<List<PigEntity>> getMatrixWithoutPigsty() async {
    Database db = await DataHelper.instance.database;
    var listMatrix = await db.rawQuery('''
      SELECT * FROM tablepigs
      WHERE pigstyName=? AND finality=?
      ''', ["Indefinido", "Matriz"]);
    List<PigEntity> matrixSelected = listMatrix.isNotEmpty
        ? listMatrix.map((c) => PigEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return matrixSelected;
  }
}
