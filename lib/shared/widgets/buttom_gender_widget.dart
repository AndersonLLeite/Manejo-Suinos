import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';

class ButtomGenderWidget extends StatelessWidget {
  final Color color;
  final String title;
  final Icon icon;

  const ButtomGenderWidget({
    Key? key,
    required this.color,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 20,
      shadowColor: AppColors.secondary,
      color: color,
      child: SizedBox(
        width: 55,
        height: 65,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Icon(
            icon.icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ]),
      ),
    );
  }
}
