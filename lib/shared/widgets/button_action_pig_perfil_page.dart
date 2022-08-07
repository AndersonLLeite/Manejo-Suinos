import 'package:flutter/material.dart';

import '../entities/pig/pig_entity.dart';

class ButtonActionPigPerfilPage extends StatelessWidget {
  const ButtonActionPigPerfilPage({
    Key? key,
    required this.title,
    required this.icon,
    required this.pigEntity,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final Icon icon;
  final PigEntity pigEntity;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: icon),
              Expanded(flex: 2, child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }
}
