// ignore_for_file: constant_identifier_names

enum Status{
  ACTIVE('ACTIVE'),
  ARCHIVED('ARCHIVED');
  
  final String value;
  const Status(this.value);
}
