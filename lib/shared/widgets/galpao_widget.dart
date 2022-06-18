import 'package:flutter/material.dart';

class Galpao extends StatelessWidget {
  const Galpao({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("galpao");
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pisoTerra.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Image.asset(
          'assets/images/galpao.png',
          height: 200,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
