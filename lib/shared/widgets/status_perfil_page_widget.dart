import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';

class StatusPerfilPageWidget extends StatelessWidget {
  const StatusPerfilPageWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Color color;
  final Icon icon;
  final String title;

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
