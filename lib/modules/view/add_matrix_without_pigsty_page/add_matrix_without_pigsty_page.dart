import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';

import '../../../data/pig_repository/pig_repository.dart';
import '../../../shared/themes/background/background_gradient.dart';
import '../../../shared/themes/colors/app_colors.dart';
import '../../../shared/widgets/card_pig_presentation_widget.dart';
import '../../model/entities/pig/pig_entity.dart';

class AddMatrixWithoutPigstyPage extends StatelessWidget {
  final PigstyEntity pigstyEntity;
  const AddMatrixWithoutPigstyPage({
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
        title: Text('Matrizes sem baia '),
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
                          .getMatrixWithoutPigsty(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PigEntity>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Loading...'));
                        }
                        return snapshot.data!.isEmpty
                            ? Center(
                                child: Text('Nenhuma matriz sem baia'),
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
                                        color: AppColors.secondary, pig: pig),
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
