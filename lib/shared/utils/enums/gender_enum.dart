// ignore_for_file: constant_identifier_names

// class Gender {
//   static const String FEMALE = 'FEMALE';
//   static const String MALE = 'MALE';
// }

enum Gender {
  FEMALE('FEMALE'),
  MALE('MALE');

  final String value;
  const Gender(this.value);
}
