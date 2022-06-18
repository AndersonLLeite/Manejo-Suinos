import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';

class Warehouse extends StatelessWidget {
  const Warehouse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print("galpao");
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundFloor),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Image.asset(
          AppImages.galpao,
          height: 200,
        ),
      ),
    );
  }
}
