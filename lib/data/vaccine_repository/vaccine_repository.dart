import 'package:flutter/cupertino.dart';
import 'package:manejo_suinos/modules/model/entities/vaccine/vaccine_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../data_helper/data_helper.dart';

class VaccineRepository extends ChangeNotifier {
  String tableVaccines =
      "CREATE TABLE tablevaccines (vaccineName TEXT, description TEXT, type TEXT, pigStage TEXT, applicationLifeDays INTEGER)";

  VaccineRepository._privateConstructor();
  static final VaccineRepository instance =
      VaccineRepository._privateConstructor();

  Future<List<VaccineEntity>> getVaccinesByPigStage(String pigStage) async {
    Database db = await DataHelper.instance.database;
    var vaccines = await db.rawQuery(
        'SELECT * FROM tablevaccines WHERE pigStage=? ORDER BY rowid',
        [pigStage]);
    List<VaccineEntity> vaccinesList = vaccines.isNotEmpty
        ? vaccines.map((c) => VaccineEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return vaccinesList;
  }

  Future<List<VaccineEntity>> getVaccines() async {
    Database db = await DataHelper.instance.database;
    var vaccines =
        await db.rawQuery('SELECT * FROM tablevaccines ORDER BY rowid', []);
    List<VaccineEntity> vaccinesList = vaccines.isNotEmpty
        ? vaccines.map((c) => VaccineEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return vaccinesList;
  }

  Future addVaccine(VaccineEntity vaccineEntity) async {
    Database db = await DataHelper.instance.database;
    await db.insert('tablevaccines', vaccineEntity.toMap());
    notifyListeners();
  }

  Future deleteVaccine(String vaccineName, String description, String pigStage,
      int applicationLifeDay) async {
    Database db = await DataHelper.instance.database;
    await db.delete('tablevaccines',
        where:
            'vaccineName= ? AND pigStage= ? AND type= ? AND applicationLifeDays =?',
        whereArgs: [vaccineName, description, pigStage, applicationLifeDay]);
  }

  Future<List<VaccineEntity>> getVaccinesByDayAndFinality(
      int age, String finality) async {
    Database db = await DataHelper.instance.database;
    var vaccines = await db.rawQuery(
        'SELECT * FROM tablevaccines WHERE applicationLifeDays >=? AND pigStage=? ',
        [age, finality]);
    List<VaccineEntity> vaccinesList = vaccines.isNotEmpty
        ? vaccines.map((c) => VaccineEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return vaccinesList;
  }
}
