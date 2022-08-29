import 'dart:convert';

class VaccineEntity {
  String vaccineName;
  String? description;
  String type;
  String pigStage;
  int applicationLifeDays;
  VaccineEntity({
    required this.vaccineName,
    this.description = "",
    required this.type,
    required this.pigStage,
    required this.applicationLifeDays,
  });

  VaccineEntity copyWith({
    String? vaccineName,
    String? description,
    String? type,
    String? pigStage,
    int? applicationLifeDays,
  }) {
    return VaccineEntity(
      vaccineName: vaccineName ?? this.vaccineName,
      description: description ?? this.description,
      type: type ?? this.type,
      pigStage: pigStage ?? this.pigStage,
      applicationLifeDays: applicationLifeDays ?? this.applicationLifeDays,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vaccineName': vaccineName,
      'description': description,
      'type': type,
      'pigStage': pigStage,
      'applicationLifeDays': applicationLifeDays,
    };
  }

  factory VaccineEntity.fromMap(Map<String, dynamic> map) {
    return VaccineEntity(
      vaccineName: map['vaccineName'] ?? '',
      description: map['description'],
      type: map['type'] ?? '',
      pigStage: map['pigStage'] ?? '',
      applicationLifeDays: map['applicationLifeDays']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccineEntity.fromJson(String source) =>
      VaccineEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VaccineEntity(vaccineName: $vaccineName, description: $description, type: $type, pigStage: $pigStage, applicationLifeDays: $applicationLifeDays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VaccineEntity &&
        other.vaccineName == vaccineName &&
        other.description == description &&
        other.type == type &&
        other.pigStage == pigStage &&
        other.applicationLifeDays == applicationLifeDays;
  }

  @override
  int get hashCode {
    return vaccineName.hashCode ^
        description.hashCode ^
        type.hashCode ^
        pigStage.hashCode ^
        applicationLifeDays.hashCode;
  }
}
