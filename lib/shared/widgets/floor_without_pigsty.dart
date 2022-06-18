import 'package:flutter/material.dart';

import '../themes/images/app_images.dart';

class FloorWithoutPigsty extends StatelessWidget {
  const FloorWithoutPigsty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundFloor),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
    );
  }
}