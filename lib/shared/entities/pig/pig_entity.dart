import 'dart:convert';

import '../../utils/enums/breed_enum.dart';
import '../../utils/enums/gender_enum.dart';
import '../../utils/enums/obtained_enum.dart';

class PigEntity {
  int id;
  String name;
  int age;
  String imageUrl;
  BreedEnum breed;
  double weight;
  GenderEnum gender;
  DateTime birthday;
  DateTime entryFarm;
  ObtainedEnum obtained;
  int motherID;
  int fatherID;

  PigEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.breed,
    required this.weight,
    required this.gender,
    required this.birthday,
    required this.entryFarm,
    required this.obtained,
    required this.motherID,
    required this.fatherID,
  });
 

  PigEntity copyWith({
    int? id,
    String? name,
    int? age,
    String? imageUrl,
    BreedEnum? breed,
    double? weight,
    GenderEnum? gender,
    DateTime? birthday,
    DateTime? entryFarm,
    ObtainedEnum? obtained,
    int? motherID,
    int? fatherID,
  }) {
    return PigEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      entryFarm: entryFarm ?? this.entryFarm,
      obtained: obtained ?? this.obtained,
      motherID: motherID ?? this.motherID,
      fatherID: fatherID ?? this.fatherID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'imageUrl': imageUrl,
      'breed': breed,
      'weight': weight,
      'gender': gender,
      'birthday': birthday.millisecondsSinceEpoch,
      'entryFarm': entryFarm.millisecondsSinceEpoch,
      'obtained': obtained,
      'motherID': motherID,
      'fatherID': fatherID,
    };
  }

  factory PigEntity.fromMap(Map<String, dynamic> map) {
    return PigEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      breed: map['breed'],
      weight: map['weight']?.toDouble() ?? 0.0,
      gender: map['gender'],
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday']),
      entryFarm: DateTime.fromMillisecondsSinceEpoch(map['entryFarm']),
      obtained: map['obtained'],
      motherID: map['motherID']?.toInt() ?? 0,
      fatherID: map['fatherID']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PigEntity.fromJson(String source) => PigEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PigEntity(id: $id, name: $name, age: $age, imageUrl: $imageUrl, breed: $breed, weight: $weight, gender: $gender, birthday: $birthday, entryFarm: $entryFarm, obtained: $obtained, motherID: $motherID, fatherID: $fatherID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PigEntity &&
      other.id == id &&
      other.name == name &&
      other.age == age &&
      other.imageUrl == imageUrl &&
      other.breed == breed &&
      other.weight == weight &&
      other.gender == gender &&
      other.birthday == birthday &&
      other.entryFarm == entryFarm &&
      other.obtained == obtained &&
      other.motherID == motherID &&
      other.fatherID == fatherID;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      age.hashCode ^
      imageUrl.hashCode ^
      breed.hashCode ^
      weight.hashCode ^
      gender.hashCode ^
      birthday.hashCode ^
      entryFarm.hashCode ^
      obtained.hashCode ^
      motherID.hashCode ^
      fatherID.hashCode;
  }
}
