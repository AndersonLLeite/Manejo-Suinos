import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';

class ButtonFinalityWidget extends StatelessWidget {
  const ButtonFinalityWidget({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      elevation: 20,
      shadowColor: AppColors.secondary,
      color: color,
      child: SizedBox(
        width: 75,
        height: 50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
