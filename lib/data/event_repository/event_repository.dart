
import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/utils/shedule_utils/shedule_utils.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/entities/event/event_entity.dart';
import '../data_helper/data_helper.dart';

class EventRepository extends ChangeNotifier {
  String tableEvents =
      "CREATE TABLE tableevents (date INTEGER, description TEXT, title TEXT, pigName TEXT)";

  EventRepository._privateConstructor();
  static final EventRepository instance =
      EventRepository._privateConstructor();

 Future addEvent(EventEntity eventEntity) async {
  Database db = await DataHelper.instance.database;
    await db.insert('tableevents', eventEntity.toMap());
    notifyListeners();
 }
 
 Future<List<EventEntity>> getEvents(String pigName) async {
    Database db = await DataHelper.instance.database;
    var events = await db.rawQuery('''
    SELECT * FROM tableevents
    WHERE pigName=?
    ''', [pigName]);
    List<EventEntity> listEvents =
        events.isNotEmpty ? events.map((c) => EventEntity.fromMap(c)).toList() : [];
    notifyListeners();
    return listEvents;
  }
}