import 'dart:convert';

class PigstyEntity {
  String name;
  String pigstyType;
  PigstyEntity({
    required this.name,
    required this.pigstyType,
  }); 

  PigstyEntity copyWith({
    String? name,
    String? pigstyType,
  }) {
    return PigstyEntity(
      name: name ?? this.name,
      pigstyType: pigstyType ?? this.pigstyType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pigstyType': pigstyType,
    };
  }

  factory PigstyEntity.fromMap(Map<String, dynamic> map) {
    return PigstyEntity(
      name: map['name'] ?? '',
      pigstyType: map['pigstyType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PigstyEntity.fromJson(String source) => PigstyEntity.fromMap(json.decode(source));

  @override
  String toString() => 'PigstyEntity(name: $name, pigstyType: $pigstyType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PigstyEntity &&
      other.name == name &&
      other.pigstyType == pigstyType;
  }

  @override
  int get hashCode => name.hashCode ^ pigstyType.hashCode;
}
