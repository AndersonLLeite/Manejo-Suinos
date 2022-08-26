import 'dart:convert';

class WeighingEntity {
  String name;
  DateTime date;
  double weight;
  int age;
  double gpd;
  WeighingEntity({
    required this.name,
    required this.date,
    required this.weight,
    required this.age,
    required this.gpd,
  });



  WeighingEntity copyWith({
    String? name,
    DateTime? date,
    double? weight,
    int? age,
    double? gpd,
  }) {
    return WeighingEntity(
      name: name ?? this.name,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      gpd: gpd ?? this.gpd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'weight': weight,
      'age': age,
      'gpd': gpd,
    };
  }

  factory WeighingEntity.fromMap(Map<String, dynamic> map) {
    return WeighingEntity(
      name: map['name'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      weight: map['weight']?.toDouble() ?? 0.0,
      age: map['age']?.toInt() ?? 0,
      gpd: map['gpd']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeighingEntity.fromJson(String source) =>
      WeighingEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeighingEntity(name: $name, date: $date, weight: $weight, age: $age, gpd: $gpd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WeighingEntity &&
      other.name == name &&
      other.date == date &&
      other.weight == weight &&
      other.age == age &&
      other.gpd == gpd;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      date.hashCode ^
      weight.hashCode ^
      age.hashCode ^
      gpd.hashCode;
  }
}
