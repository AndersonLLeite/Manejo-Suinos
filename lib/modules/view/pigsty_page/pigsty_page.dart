import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';
import 'package:manejo_suinos/modules/view/add_pigs_without_pigsty/add_pigs_without_pigsty.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';

import '../../../data/pig_repository/pig_repository.dart';
import '../../../shared/themes/colors/app_colors.dart';
import '../../../shared/utils/enums/gender_enum.dart';
import '../../../shared/widgets/card_pig_presentation_widget.dart';
import '../../model/entities/pig/pig_entity.dart';
import '../personal_pig_page_view/personal_pig_page_view.dart';

class PigstyPage extends StatelessWidget {
  final PigstyEntity pigstyEntity;
  const PigstyPage({
    Key? key,
    required this.pigstyEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Baia - ${pigstyEntity.pigstyName}'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      
      body: BackgroundGradient(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded( 
                  child: FutureBuilder<List<PigEntity>>(
                      future: context.watch<PigRepository>().getPigsByPigsty(pigstyEntity),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PigEntity>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Loading...'));
                        }
                        return snapshot.data!.isEmpty
                            ? Center(
                                child: Text('Nenhum suino nessa baia'),
                              )
                            : ListView(
                                children: snapshot.data!.map((pig) {
                                  return GestureDetector(
                                    onTap: () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalPigPageView(
                                              pigEntity: pig,
                                            ),
                                          ),
                                        );
                                     
                                    },
                                    child: CardPigPresentationWidget(
                                        color: pig.gender == Gender.MALE.value
                                            ? AppColors.primary
                                            : AppColors.secondary,
                                        pig: pig),
                                  );
                                }).toList(),
                              );
                      }),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 38, horizontal: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => AddPigsWithoutPigsty(pigstyEntity: pigstyEntity))));
                    },
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(flex: 1, child: Icon(Icons.add)),
                        Expanded(flex: 2, child: Text("Adicionar Suino")),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        ),
    );
  }
}
