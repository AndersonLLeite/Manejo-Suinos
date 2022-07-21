import 'package:flutter/material.dart';

import '../themes/colors/app_colors.dart';

class CardBreedWidget extends StatefulWidget {
  const CardBreedWidget({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  final String title;
  final String image;

  @override
  State<CardBreedWidget> createState() => _CardBreedWidgetState();
}

class _CardBreedWidgetState extends State<CardBreedWidget> {
  double _slideValue = 0;
  Color cor = AppColors.defaultColorButtomDisabled;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      elevation: 20,
      shadowColor: AppColors.secondary,
      color: cor,
      child: SizedBox(
        width: 150,
        height: 100,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(widget.image),
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Slider(
              thumbColor: AppColors.secondary,
              activeColor: AppColors.secondary,
              inactiveColor: Colors.black,
              label: 'Selecione a porcentagem de raça de ${widget.title}',
              divisions: 4,
              min: 0,
              max: 100,
              value: _slideValue,
              onChanged: (value) {
                if (value > 0) {
                  setState(() {
                    cor = AppColors.primary;
                  });
                } else {
                  setState(() {
                    cor = AppColors.defaultColorButtomDisabled;
                  });
                }
                setState(() {
                  _slideValue = value;
                });
              }),
          Text(
            _slideValue.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          )
        ]),
      ),
    );
  }
}
