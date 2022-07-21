import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/entities/heighing_entity/weighing_entity.dart';
import '../data_helper/data_helper.dart';

class WeighingRepository extends ChangeNotifier {
  String tableWeighing =
      "CREATE TABLE tableweighings (name TEXT, date TEXT, weight REAL, age INTEGER, gpd REAL)";

  WeighingRepository._privateConstructor();
  static final WeighingRepository instance =
      WeighingRepository._privateConstructor();

  Future addWeighing(WeighingEntity weighingEntity) async {
    Database db = await DataHelper.instance.database;
    await db.insert('tableweighings', weighingEntity.toMap());
    notifyListeners();
  }

  Future removeWeighing(int age, String date, double weight) async {
    Database db = await DataHelper.instance.database;
    await db.delete('tableweighings',
        where: 'age= ? AND date= ? AND weight= ?',
        whereArgs: [age, date, weight]);
    notifyListeners();
  }

  Future removeWeighingByPigName(String name) async {
    Database db = await DataHelper.instance.database;
    await db.delete('tableweighings', where: 'name=?', whereArgs: [name]);
    notifyListeners();
  }

  Future<List<WeighingEntity>> getWeighings(String name) async {
    Database db = await DataHelper.instance.database;
    var weighings = await db.rawQuery(
        'SELECT * FROM tableweighings WHERE name=? ORDER BY rowid', [name]);
    List<WeighingEntity> weighingsList = weighings.isNotEmpty
        ? weighings.map((c) => WeighingEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return weighingsList;
  }

  Future<double> getLastWeight(String name) async {
    Database db = await DataHelper.instance.database;
    var lastPig = await db.rawQuery('''
      SELECT * FROM tableweighings
      WHERE name=?
      ORDER BY age DESC
      LIMIT 1
      ''', [name]);
    List<WeighingEntity> lastPigList = lastPig.isNotEmpty
        ? lastPig.map((c) => WeighingEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return lastPigList.isEmpty ? 0.0 : lastPigList[0].weight;
  }

  Future<int> getLastAge(String name) async {
    Database db = await DataHelper.instance.database;
    var lastPig = await db.rawQuery('''
      SELECT * FROM tableweighings
      WHERE name=?
      ORDER BY age DESC
      LIMIT 1
      ''', [name]);
    List<WeighingEntity> lastPigList = lastPig.isNotEmpty
        ? lastPig.map((c) => WeighingEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return lastPigList.isEmpty ? 0 : lastPigList[0].age;
  }
}
