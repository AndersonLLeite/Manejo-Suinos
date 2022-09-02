import 'dart:convert';

import 'package:manejo_suinos/shared/themes/images/app_images.dart';
import 'package:manejo_suinos/shared/utils/enums/status_enum.dart';

class PigEntity {
  String name;
  String imageUrl;
  int age;
  double weight;
  double gpd;
  String gender;
  String finality;
  String obtained;
  String motherName;
  String fatherName;
  String status;
  double buyValue;
  double sellValue;
  int isPregnant;
  DateTime birthday;
  String pigstyName;

  PigEntity({
    required this.name,
    this.imageUrl = AppImages.pig,
    required this.age,
    required this.weight,
    required this.gpd,
    required this.gender,
    required this.finality,
    required this.obtained,
    required this.motherName,
    required this.fatherName,
    this.status = 'ACTIVE',
    required this.buyValue,
    required this.sellValue,
    this.isPregnant = 0,
    required this.birthday,
    this.pigstyName = "Indefinido",
  });

  PigEntity copyWith({
    String? name,
    String? imageUrl,
    int? age,
    double? weight,
    double? gpd,
    String? gender,
    String? finality,
    String? obtained,
    String? motherName,
    String? fatherName,
    String? status,
    double? buyValue,
    double? sellValue,
    int? isPregnant,
    DateTime? birthday,
    String? pigstyName,
  }) {
    return PigEntity(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gpd: gpd ?? this.gpd,
      gender: gender ?? this.gender,
      finality: finality ?? this.finality,
      obtained: obtained ?? this.obtained,
      motherName: motherName ?? this.motherName,
      fatherName: fatherName ?? this.fatherName,
      status: status ?? this.status,
      buyValue: buyValue ?? this.buyValue,
      sellValue: sellValue ?? this.sellValue,
      isPregnant: isPregnant ?? this.isPregnant,
      birthday: birthday ?? this.birthday,
      pigstyName: pigstyName ?? this.pigstyName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'age': age,
      'weight': weight,
      'gpd': gpd,
      'gender': gender,
      'finality': finality,
      'obtained': obtained,
      'motherName': motherName,
      'fatherName': fatherName,
      'status': status,
      'buyValue': buyValue,
      'sellValue': sellValue,
      'isPregnant': isPregnant,
      'birthday': birthday.millisecondsSinceEpoch,
      'pigstyName': pigstyName,
    };
  }

  factory PigEntity.fromMap(Map<String, dynamic> map) {
    return PigEntity(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      age: map['age']?.toInt() ?? 0,
      weight: map['weight']?.toDouble() ?? 0.0,
      gpd: map['gpd']?.toDouble() ?? 0.0,
      gender: map['gender'] ?? '',
      finality: map['finality'] ?? '',
      obtained: map['obtained'] ?? '',
      motherName: map['motherName'] ?? '',
      fatherName: map['fatherName'] ?? '',
      status: map['status'] ?? '',
      buyValue: map['buyValue']?.toDouble() ?? 0.0,
      sellValue: map['sellValue']?.toDouble() ?? 0.0,
      isPregnant: map['isPregnant']?.toInt() ?? 0,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday']),
      pigstyName: map['pigstyName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PigEntity.fromJson(String source) =>
      PigEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PigEntity(name: $name, imageUrl: $imageUrl, age: $age, weight: $weight, gpd: $gpd, gender: $gender, finality: $finality, obtained: $obtained, motherName: $motherName, fatherName: $fatherName, status: $status, buyValue: $buyValue, sellValue: $sellValue, isPregnant: $isPregnant, birthday: $birthday, pigstyName: $pigstyName)';
  }

  String? getStatus() {
    return status;
  }

  setStatus(Status status) {
    this.status = status.value;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PigEntity &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.age == age &&
      other.weight == weight &&
      other.gpd == gpd &&
      other.gender == gender &&
      other.finality == finality &&
      other.obtained == obtained &&
      other.motherName == motherName &&
      other.fatherName == fatherName &&
      other.status == status &&
      other.buyValue == buyValue &&
      other.sellValue == sellValue &&
      other.isPregnant == isPregnant &&
      other.birthday == birthday &&
      other.pigstyName == pigstyName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      imageUrl.hashCode ^
      age.hashCode ^
      weight.hashCode ^
      gpd.hashCode ^
      gender.hashCode ^
      finality.hashCode ^
      obtained.hashCode ^
      motherName.hashCode ^
      fatherName.hashCode ^
      status.hashCode ^
      buyValue.hashCode ^
      sellValue.hashCode ^
      isPregnant.hashCode ^
      birthday.hashCode ^
      pigstyName.hashCode;
  }
}
