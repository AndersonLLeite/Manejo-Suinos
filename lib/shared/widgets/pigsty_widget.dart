import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';

class Pigsty extends StatelessWidget {
  const Pigsty({Key? key}) : super(key: key);

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
            image: AssetImage(AppImages.backgroundFloor),
            fit: BoxFit.cover,
          ),
        ),
        child: Image.asset(
          AppImages.baiaVertical,
          height: 200,
        ),
      ),
    );
  }
}
