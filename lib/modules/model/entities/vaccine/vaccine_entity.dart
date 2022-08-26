import 'dart:convert';

class VaccineEntity {
  String vaccineName;
  String? description;
  String type;
  String pigStage;
  int firstApplicationLifeDays;
  int? repeatApplicationLifeDays;
  VaccineEntity({
    required this.vaccineName,
    this.description = "",
    required this.type,
    required this.pigStage,
    required this.firstApplicationLifeDays,
    this.repeatApplicationLifeDays = 0,
  });

  VaccineEntity copyWith({
    String? vaccineName,
    String? description,
    String? type,
    String? pigStage,
    int? firstApplicationLifeDays,
    int? repeatApplicationLifeDays,
  }) {
    return VaccineEntity(
      vaccineName: vaccineName ?? this.vaccineName,
      description: description ?? this.description,
      type: type ?? this.type,
      pigStage: pigStage ?? this.pigStage,
      firstApplicationLifeDays:
          firstApplicationLifeDays ?? this.firstApplicationLifeDays,
      repeatApplicationLifeDays:
          repeatApplicationLifeDays ?? this.repeatApplicationLifeDays,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vaccineName': vaccineName,
      'description': description,
      'type': type,
      'pigStage': pigStage,
      'firstApplicationLifeDays': firstApplicationLifeDays,
      'repeatApplicationLifeDays': repeatApplicationLifeDays,
    };
  }

  factory VaccineEntity.fromMap(Map<String, dynamic> map) {
    return VaccineEntity(
      vaccineName: map['vaccineName'] ?? '',
      description: map['description'],
      type: map['type'] ?? '',
      pigStage: map['pigStage'] ?? '',
      firstApplicationLifeDays: map['firstApplicationLifeDays']?.toInt() ?? 0,
      repeatApplicationLifeDays: map['repeatApplicationLifeDays']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccineEntity.fromJson(String source) =>
      VaccineEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VaccineEntity(vaccineName: $vaccineName, description: $description, type: $type, pigStage: $pigStage, firstApplicationLifeDays: $firstApplicationLifeDays, repeatApplicationLifeDays: $repeatApplicationLifeDays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VaccineEntity &&
        other.vaccineName == vaccineName &&
        other.description == description &&
        other.type == type &&
        other.pigStage == pigStage &&
        other.firstApplicationLifeDays == firstApplicationLifeDays &&
        other.repeatApplicationLifeDays == repeatApplicationLifeDays;
  }

  @override
  int get hashCode {
    return vaccineName.hashCode ^
        description.hashCode ^
        type.hashCode ^
        pigStage.hashCode ^
        firstApplicationLifeDays.hashCode ^
        repeatApplicationLifeDays.hashCode;
  }
}
