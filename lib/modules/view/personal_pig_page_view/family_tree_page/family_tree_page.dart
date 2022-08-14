import 'package:flutter/material.dart';

import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/themes/colors/app_colors.dart';
import 'package:manejo_suinos/shared/widgets/card_pig_presentation_widget.dart';

import '../../../model/entities/pig/pig_entity.dart';


class FamilyTreePage extends StatelessWidget {

  final PigEntity grandFatherMother;
  final PigEntity grandMotherMother;
  final PigEntity grandFatherFather;
  final PigEntity grandMotherFather;
  final PigEntity father;
  final PigEntity mother;
  final PigEntity pig;

  const FamilyTreePage({
    Key? key,
    required this.grandFatherMother,
    required this.grandMotherMother,
    required this.grandFatherFather,
    required this.grandMotherFather,
    required this.father,
    required this.mother,
    required this.pig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: BackgroundGradient(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 150,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: grandFatherMother,
                    ),
                  ),
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: grandFatherFather,
                    ),
                  ),
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: grandMotherMother,
                    ),
                  ),
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: grandMotherFather,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: father,
                    ),
                  ),
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: mother,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: CardPigPresentationWidget(
                      color: AppColors.primary,
                      pig: pig,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
