import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/widgets/text_rich_perfil_page_widget.dart';

import '../entities/pig/pig_entity.dart';
import '../themes/colors/app_colors.dart';
import '../themes/styles/textstyles/app_text_styles.dart';

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
            height: MediaQuery.of(context).size.height * 0.17,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRichPerfilPageWidget(
                        text: "Nome: ", textValue: pig.name),
                    TextRichPerfilPageWidget(
                        text: "Idade: ", textValue: pig.age.toString()),
                    TextRichPerfilPageWidget(
                        text: "Peso: ", textValue: pig.weight.toString()),
                    TextRichPerfilPageWidget(
                      text: "Finalidade: ",
                      textValue: pig.finality,
                    ),
                    TextRichPerfilPageWidget(
                        text: "Sexo: ",
                        textValue: pig.gender == Gender.FEMALE.value
                            ? "Fêmea"
                            : "Macho"),
                  ],
                )
              ],
            )),
      ),
    );
  }
}


// Center(
//       child: Stack(
//         children: [
//           Card(
//             color: color,
//             shadowColor: color == AppColors.secondary
//                 ? AppColors.primary
//                 : AppColors.secondary,
//             elevation: 20,
//             margin: EdgeInsets.all(20),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(40),
//                 topLeft: Radius.circular(20),
//               ),
//             ),
//             child: SizedBox(
//               height: 100,
//               width: 90,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: CircleAvatar(
//               radius: 40,
//               backgroundImage: Image.asset('assets/images/pig.jpeg').image,
//             ),
//           ),
//           Positioned(
//             top: 25,
//             left: 25,
//             child: Text(      
//               pig.name,
//               style: AppTextStyles.titleCardPigPresentation,
//             ),
//           ),
//         ],
//       ),
//     );