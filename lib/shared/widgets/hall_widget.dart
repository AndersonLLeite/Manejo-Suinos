import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';

class Hall extends StatelessWidget {
  const Hall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.corredor,
      height: 200,
    );
  }
}