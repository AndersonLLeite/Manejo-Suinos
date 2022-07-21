import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';

import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/status_enum.dart';
import 'package:manejo_suinos/shared/widgets/buttom_finality_widget.dart';
import 'package:manejo_suinos/shared/widgets/buttom_gender_widget.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/themes/colors/app_colors.dart';
import '../../shared/widgets/text_rich_perfil_page_widget.dart';

class PerfilPigPage extends StatelessWidget {
  final PigEntity pigEntity;
  const PerfilPigPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(pigEntity.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await Provider.of<PigRepository>(context, listen: false)
                    .removePig(pigEntity.name);
                await Provider.of<WeighingRepository>(context, listen: false)
                    .removeWeighingByPigName(pigEntity.name);
              },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                PigEntity archivedPigEntity = pigEntity.copyWith(
                  status: pigEntity.getStatus() == "ACTIVE"? Status.ARCHIVED.value: Status.ACTIVE.value
                );
                await Provider.of<PigRepository>(context, listen: false)
                    .updatePig(archivedPigEntity);
              },
              icon: Icon(pigEntity.getStatus() == "ACTIVE"? Icons.archive: Icons.unarchive)),
        ],
      ),
      body: BackgroundGradient(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    backgroundImage: Image.asset(pigEntity.imageUrl).image,
                    radius: 80,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRichPerfilPageWidget(
                        text: "nome: ",
                        textValue: pigEntity.name,
                      ),
                      TextRichPerfilPageWidget(
                        text: "Idade: ",
                        textValue: pigEntity.age.toString(),
                      ),
                      TextRichPerfilPageWidget(
                        text: "Peso: ",
                        textValue: pigEntity.weight.toString(),
                      ),
                      TextRichPerfilPageWidget(
                        text: "GPD atual: ",
                        textValue: pigEntity.gpd.toString(),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                pigEntity.gender == Gender.FEMALE.value
                    ? ButtomGenderWidget(
                        color: AppColors.secondary,
                        title: 'Fêmea',
                        icon: Icon(Icons.female))
                    : ButtomGenderWidget(
                        color: AppColors.primary,
                        title: 'Macho',
                        icon: Icon(Icons.male),
                      ),
                ButtomFinalityWidget(
                    color: AppColors.primary, title: pigEntity.finality),
              ],
            )
          ],
        ),
      ),
    );
  }
}
