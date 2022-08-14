// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../../../data/event_repository/event_repository.dart';
import '../../../modules/model/entities/event/event_entity.dart';


/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<EventEntity>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

void setEventSource(List<EventEntity> events) {
  for (final event in events) {
    _kEventSource[event.date] ??= [];
    _kEventSource[DateTime(event.date.year, event.date.month, event.date.day)]!
        .add(event);
  }
}

void deleteEventToSource(EventEntity event) {
  _kEventSource[event.date]!.remove(event);
}

void refreshEventsSource() async {
  _kEventSource.clear();
  List<EventEntity> events = await EventRepository.instance.getAllEvents();
  setEventSource(events);
}

Map<DateTime, List<EventEntity>> getkEventSource() {
  return _kEventSource;
}

final Map<DateTime, List<EventEntity>> _kEventSource = {};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

String formatDate(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(4, '0')}";
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);
