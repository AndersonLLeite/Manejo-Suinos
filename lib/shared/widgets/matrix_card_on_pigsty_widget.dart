import 'package:flutter/material.dart';

class MatrixCardOnPigstyWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  const MatrixCardOnPigstyWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [icon, Text(title)],
          )),
        ));
  }
}