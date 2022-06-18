import 'package:flutter/material.dart';

class Corredor extends StatelessWidget {
  const Corredor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/corredor.png',
      height: 200,
    );
  }
}