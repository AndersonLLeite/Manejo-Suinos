import 'package:flutter/material.dart';

class BaiaWidget extends StatelessWidget {
  const BaiaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print('clicou baia');
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pisoTerra.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Image.asset(
          'assets/images/baiaVertical.png',
          height: 200,
        ),
      ),
    );
  }
}
