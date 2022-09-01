import 'package:flutter/cupertino.dart';
import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';
import 'package:manejo_suinos/modules/view/pigsty_page/pigsty_page.dart';
import 'package:sqflite/sqflite.dart';

import '../data_helper/data_helper.dart';

class PigstyRepository extends ChangeNotifier {
  String tablePigsty =
      "CREATE TABLE tablePigsty (name TEXT PRIMARY KEY, pigstyType TEXT)";

  PigstyRepository._privateConstructor();
  static final PigstyRepository instance =
      PigstyRepository._privateConstructor();

  Future<List<PigstyEntity>> getAllPigsty() async {
    Database db = await DataHelper.instance.database;
    var pigstys = await db.rawQuery('''SELECT * FROM tablePigsty''');
    List<PigstyEntity> listPigsty = pigstys.isNotEmpty
        ? pigstys.map((c) => PigstyEntity.fromMap(c)).toList()
        : [];
    return listPigsty;
  }

}
