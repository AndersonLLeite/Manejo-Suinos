// ignore_for_file: constant_identifier_names

// class Breed {
//   static const String LANDRACE = 'LANDRACE';
//   static const String DUROC = 'DUROC';
//   static const String LARGE_WHITE = 'LARGE_WHITE';
//   static const String PIETRAIN = 'PIETRAIN';
// }
enum Breed{
  LANDRACE('LANDRACE'),
  DUROC('DUROC'),
  LARGE_WHITE('LARGE_WHITE'),
  PIETRAIN('PIETRAIN');
  
  final String value;
  const Breed(this.value);
}
