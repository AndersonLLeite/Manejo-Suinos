// ignore_for_file: constant_identifier_names

// class Obtained {
//   static const String BORN = 'BORN';
//   static const String PURCHASED = 'PURCHASED';
// }

enum Obtained {
  BORN('Nascido'),
  PURCHASED('Comprado');

  final String value;
  const Obtained(this.value);
}
