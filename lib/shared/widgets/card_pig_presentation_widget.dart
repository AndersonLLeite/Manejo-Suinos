import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/widgets/button_gender_widget.dart';
import 'package:manejo_suinos/shared/widgets/status_perfil_page_widget.dart';

import '../../modules/model/entities/pig/pig_entity.dart';
import '../themes/colors/app_colors.dart';
import '../themes/styles/textstyles/app_text_styles.dart';
import 'button_finality_widget.dart';

class CardPigPresentationWidget extends StatelessWidget {
  const CardPigPresentationWidget({
    Key? key,
    required this.color,
    required this.pig,
  }) : super(key: key);

  final Color color;
  final PigEntity pig;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          pig.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      pig.name,
                      style: AppTextStyles.titleNamePigPresentationCard,
                    ),
                    Row(
                      children: [
                        pig.gender == Gender.FEMALE.value
                            ? ButtonGenderWidget(
                                color: AppColors.secondary,
                                title: "Fêmea",
                                icon: Icon(Icons.female))
                            : ButtonGenderWidget(
                                color: AppColors.primary,
                                title: "Macho",
                                icon: Icon(Icons.male)),
                        ButtonFinalityWidget(
                            color: pig.gender == Gender.FEMALE.value
                                ? AppColors.secondary
                                : AppColors.primary,
                            title: pig.finality),
                        pig.getStatus() == "ARCHIVED"
                            ? StatusPerfilPageWidget(
                                color: pig.sellValue > 0
                                    ? AppColors.sellColor
                                    : AppColors.deathColor,
                                title: pig.sellValue > 0 ? 'Venda' : 'Morto',
                                icon: pig.sellValue > 0
                                    ? Icon(Icons.attach_money)
                                    : Icon(Icons.health_and_safety_outlined),
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
