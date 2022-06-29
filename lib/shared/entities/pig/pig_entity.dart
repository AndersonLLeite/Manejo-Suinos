import 'dart:convert';

import 'package:manejo_suinos/shared/themes/images/app_images.dart';

class PigEntity {
  String name;
  String? imageUrl = AppImages.pig;
  int age;
  double weight;
  String gender;
  String finality;
  String obtained;
  String? motherName = "'Indefinido'";
  String? fatherName = "Indefinido";
  String breed;

  PigEntity({
    required this.name,
    this.imageUrl,
    required this.age,
    required this.weight,
    required this.gender,
    required this.finality,
    required this.obtained,
    this.motherName,
    this.fatherName,
    required this.breed,
  });

  PigEntity copyWith({
    String? name,
    String? imageUrl,
    int? age,
    double? weight,
    String? gender,
    String? finality,
    String? obtained,
    String? motherName,
    String? fatherName,
    String? breed,
  }) {
    return PigEntity(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      finality: finality ?? this.finality,
      obtained: obtained ?? this.obtained,
      motherName: motherName ?? this.motherName,
      fatherName: fatherName ?? this.fatherName,
      breed: breed ?? this.breed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'age': age,
      'weight': weight,
      'gender': gender,
      'finality': finality,
      'obtained': obtained,
      'motherName': motherName,
      'fatherName': fatherName,
      'breed': breed,
    };
  }

  factory PigEntity.fromMap(Map<String, dynamic> map) {
    return PigEntity(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'],
      age: map['age']?.toInt() ?? 0,
      weight: map['weight']?.toDouble() ?? 0.0,
      gender: map['gender'] ?? '',
      finality: map['finality'] ?? '',
      obtained: map['obtained'] ?? '',
      motherName: map['motherName'],
      fatherName: map['fatherName'],
      breed: map['breed'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PigEntity.fromJson(String source) =>
      PigEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PigEntity(name: $name, imageUrl: $imageUrl, age: $age, weight: $weight, gender: $gender, finality: $finality, obtained: $obtained, motherName: $motherName, fatherName: $fatherName, breed: $breed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PigEntity &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.age == age &&
      other.weight == weight &&
      other.gender == gender &&
      other.finality == finality &&
      other.obtained == obtained &&
      other.motherName == motherName &&
      other.fatherName == fatherName &&
      other.breed == breed;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      imageUrl.hashCode ^
      age.hashCode ^
      weight.hashCode ^
      gender.hashCode ^
      finality.hashCode ^
      obtained.hashCode ^
      motherName.hashCode ^
      fatherName.hashCode ^
      breed.hashCode;
  }
}
