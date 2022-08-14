import 'package:flutter/material.dart';

import '../../modules/model/entities/pig/pig_entity.dart';
import '../themes/colors/app_colors.dart';
import '../themes/styles/textstyles/app_text_styles.dart';

class CardPigParent extends StatelessWidget {
  const CardPigParent({
    Key? key,
    required this.color, 
    required this.pig,
  }) : super(key: key);

  final Color color;
  final PigEntity pig;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Card(
            color: color,
            shadowColor: color == AppColors.secondary
                ? AppColors.primary
                : AppColors.secondary,
            elevation: 20,
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                topLeft: Radius.circular(20),
              ),
            ),
            child: SizedBox(
              height: 100,
              width: 90,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: Image.asset('assets/images/pig.jpeg').image,
            ),
          ),
          Positioned(
            top: 25,
            left: 25,
            child: Text(      
              pig.name,
              style: AppTextStyles.titleCardPigPresentation,
            ),
          ),
        ],
      ),
    );
  }
}