import 'dart:convert';

class EventEntity {
  DateTime date;
  String? description;
  String title;
  String pigName;
  String type;
  EventEntity({
    required this.date,
    this.description,
    required this.title,
    required this.pigName,
    required this.type,
  });

  EventEntity copyWith({
    DateTime? date,
    String? description,
    String? title,
    String? pigName,
    String? type,
  }) {
    return EventEntity(
      date: date ?? this.date,
      description: description ?? this.description,
      title: title ?? this.title,
      pigName: pigName ?? this.pigName,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'title': title,
      'pigName': pigName,
      'type': type,
    };
  }

  factory EventEntity.fromMap(Map<String, dynamic> map) {
    return EventEntity(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      description: map['description'],
      title: map['title'] ?? '',
      pigName: map['pigName'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventEntity.fromJson(String source) =>
      EventEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventEntity(date: $date, description: $description, title: $title, pigName: $pigName, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EventEntity &&
      other.date == date &&
      other.description == description &&
      other.title == title &&
      other.pigName == pigName &&
      other.type == type;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      description.hashCode ^
      title.hashCode ^
      pigName.hashCode ^
      type.hashCode;
  }
}
