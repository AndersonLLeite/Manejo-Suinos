import 'package:flutter/material.dart';

import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';
import 'package:manejo_suinos/modules/view/personal_pig_page_view/perfil_pig_page/perfil_pig_page.dart';
import 'package:manejo_suinos/modules/view/personal_pig_page_view/personal_pig_page_view.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/themes/colors/app_colors.dart';
import 'package:manejo_suinos/shared/themes/styles/textstyles/app_text_styles.dart';
import 'package:manejo_suinos/shared/widgets/card_pig_presentation_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/pig_repository/pig_repository.dart';
import '../../../shared/utils/shedule_utils/shedule_utils.dart';
import '../../../shared/widgets/matrix_card_on_pigsty_widget.dart';
import '../../model/entities/pig/pig_entity.dart';
import '../add_matrix_without_pigsty_page/add_matrix_without_pigsty_page.dart';

class MaternityPigstyPage extends StatefulWidget {
  final PigstyEntity pigstyEntity;
  const MaternityPigstyPage({
    Key? key,
    required this.pigstyEntity,
  }) : super(key: key);

  @override
  State<MaternityPigstyPage> createState() => _MaternityPigstyPageState();
}

class _MaternityPigstyPageState extends State<MaternityPigstyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Maternidade - ${widget.pigstyEntity.pigstyName}'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBody: true,

      body: BackgroundGradient(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
                child: Text(
              "Matriz",
              style: AppTextStyles.titleMaternity,
            )),
            FutureBuilder(
                future: context
                    .watch<PigRepository>()
                    .getMatrixByPigstyName(widget.pigstyEntity.pigstyName),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PigEntity>> snapshot) {
                  if (!snapshot.hasData) {
                    return MatrixCardOnPigstyWidget(
                      icon: Icon(Icons.replay_circle_filled),
                      title: "Carregando",
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddMatrixWithoutPigstyPage(
                                          pigstyEntity: widget.pigstyEntity,
                                        )));
                          },
                          child: MatrixCardOnPigstyWidget(
                              icon: Icon(Icons.add),
                              title: "Clique para adicionar a matriz"),
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            PersonalPigPageView(
                                                pigEntity:
                                                    snapshot.data![0]))));
                              },
                              child: CardPigPresentationWidget(
                                  color: AppColors.secondary,
                                  pig: snapshot.data![0]),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  PigEntity matriz = snapshot.data![0]
                                      .copyWith(pigstyName: 'Indefinido');
                                  PigRepository.instance.updatePig(matriz);
                                },
                                child: Text("Remover matriz")),
                          ],
                        );
                }),
          ],
        ),
      ),
    );
  }
}
