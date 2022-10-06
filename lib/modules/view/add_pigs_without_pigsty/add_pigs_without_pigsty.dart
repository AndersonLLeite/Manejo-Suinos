import 'package:flutter/material.dart';

import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';
import 'package:provider/provider.dart';

import '../../../data/pig_repository/pig_repository.dart';
import '../../../shared/themes/background/background_gradient.dart';
import '../../../shared/themes/colors/app_colors.dart';
import '../../../shared/utils/enums/gender_enum.dart';
import '../../../shared/widgets/card_pig_presentation_widget.dart';
import '../../model/entities/pig/pig_entity.dart';

class AddPigsWithoutPigsty extends StatelessWidget {
  final PigstyEntity pigstyEntity;
  const AddPigsWithoutPigsty({
    Key? key,
    required this.pigstyEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Suinos sem baia '),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBody: true,
      body: BackgroundGradient(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<PigEntity>>(
                      future: context
                          .watch<PigRepository>()
                          .getPigsWithoutPigsty(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PigEntity>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Loading...'));
                        }
                        return snapshot.data!.isEmpty
                            ? Center(
                                child: Text('Nenhum suino sem baia'),
                              )
                            : ListView(
                                children: snapshot.data!.map((pig) {
                                  return GestureDetector(
                                    onTap: () async {
                                      PigEntity pigEntity;
                                      pigEntity = pig.copyWith(
                                          pigstyName: pigstyEntity.pigstyName);
                                      await PigRepository.instance
                                          .updatePig(pigEntity);
                                      Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
