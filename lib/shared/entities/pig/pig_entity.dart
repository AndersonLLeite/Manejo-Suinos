import 'dart:convert';

import 'package:manejo_suinos/shared/themes/images/app_images.dart';

class PigEntity {
  String name;
  int age;
  double weight;
  String? imageUrl = AppImages.pigs;
  String breed;
  String obtained;
  String gender;
  String? motherName = "'Indefinido'";
  String? fatherName = "Indefinido";

  PigEntity({
    required this.name,
    required this.age,
    required this.weight,
    this.imageUrl,
    required this.breed,
    required this.obtained,
    required this.gender,
    this.motherName,
    this.fatherName,
  });

  PigEntity copyWith({
    String? name,
    int? age,
    double? weight,
    String? imageUrl,
    String? breed,
    String? obtained,
    String? gender,
    String? motherName,
    String? fatherName,
  }) {
    return PigEntity(
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      obtained: obtained ?? this.obtained,
      gender: gender ?? this.gender,
      motherName: motherName ?? this.motherName,
      fatherName: fatherName ?? this.fatherName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'imageUrl': imageUrl,
      'breed': breed,
      'obtained': obtained,
      'gender': gender,
      'motherName': motherName,
      'fatherName': fatherName,
    };
  }

  factory PigEntity.fromMap(Map<String, dynamic> map) {
    return PigEntity(
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      weight: map['weight']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'],
      breed: map['breed'] ?? '',
      obtained: map['obtained'] ?? '',
      gender: map['gender'] ?? '',
      motherName: map['motherName'],
      fatherName: map['fatherName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PigEntity.fromJson(String source) =>
      PigEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PigEntity(name: $name, age: $age, weight: $weight, imageUrl: $imageUrl, breed: $breed, obtained: $obtained, gender: $gender, motherName: $motherName, fatherName: $fatherName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PigEntity &&
      other.name == name &&
      other.age == age &&
      other.weight == weight &&
      other.imageUrl == imageUrl &&
      other.breed == breed &&
      other.obtained == obtained &&
      other.gender == gender &&
      other.motherName == motherName &&
      other.fatherName == fatherName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      age.hashCode ^
      weight.hashCode ^
      imageUrl.hashCode ^
      breed.hashCode ^
      obtained.hashCode ^
      gender.hashCode ^
      motherName.hashCode ^
      fatherName.hashCode;
  }
}
