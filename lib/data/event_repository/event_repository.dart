import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/entities/event/event_entity.dart';
import '../data_helper/data_helper.dart';

class EventRepository extends ChangeNotifier {
  String tableEvents =
      "CREATE TABLE tableevents (date INTEGER, description TEXT, title TEXT, pigName TEXT)";

  EventRepository._privateConstructor();
  static final EventRepository instance = EventRepository._privateConstructor();

  Future addEvent(EventEntity eventEntity) async {
    Database db = await DataHelper.instance.database;
    await db.insert('tableevents', eventEntity.toMap());
    notifyListeners();
  }

  Future<List<EventEntity>> getAllEvents() async {
    Database db = await DataHelper.instance.database;
    var events = await db.rawQuery(
        'SELECT * FROM tableevents ORDER BY date DESC', []);
    List<EventEntity> eventsList = events.isNotEmpty
        ? events.map((c) => EventEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return eventsList;
  }

  Future<List<EventEntity>> getEventsByPigName(String pigName) async {
    Database db = await DataHelper.instance.database;
    var events = await db.rawQuery('''
    SELECT * FROM tableevents
    WHERE pigName=?
    ''', [pigName]);
    List<EventEntity> listEvents = events.isNotEmpty
        ? events.map((c) => EventEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listEvents;
  }

  Future<List<EventEntity>> getEventsByDate(DateTime date) async {
    Database db = await DataHelper.instance.database;
    var events = await db.rawQuery('''
    SELECT * FROM tableevents
    WHERE date=?
    ''', [date.millisecondsSinceEpoch]);
    List<EventEntity> listEvents = events.isNotEmpty
        ? events.map((c) => EventEntity.fromMap(c)).toList()
        : [];
    notifyListeners();
    return listEvents;
  }
}
