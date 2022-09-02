import 'dart:convert';

class PigstyEntity {
  String pigstyName;
  String pigstyType;
  PigstyEntity({
    required this.pigstyName,
    required this.pigstyType,
  });

  PigstyEntity copyWith({
    String? pigstyName,
    String? pigstyType,
  }) {
    return PigstyEntity(
      pigstyName: pigstyName ?? this.pigstyName,
      pigstyType: pigstyType ?? this.pigstyType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pigstyName': pigstyName,
      'pigstyType': pigstyType,
    };
  }

  factory PigstyEntity.fromMap(Map<String, dynamic> map) {
    return PigstyEntity(
      pigstyName: map['pigstyName'] ?? '',
      pigstyType: map['pigstyType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PigstyEntity.fromJson(String source) =>
      PigstyEntity.fromMap(json.decode(source));

  @override
  String toString() => 'PigstyEntity(pigstyName: $pigstyName, pigstyType: $pigstyType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PigstyEntity &&
        other.pigstyName == pigstyName &&
        other.pigstyType == pigstyType;
  }

  @override
  int get hashCode => pigstyName.hashCode ^ pigstyType.hashCode;
}
