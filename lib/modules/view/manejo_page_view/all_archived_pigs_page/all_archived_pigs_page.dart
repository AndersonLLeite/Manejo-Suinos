import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:provider/provider.dart';

import '../../../../shared/themes/background/background_gradient.dart';
import '../../../../shared/themes/colors/app_colors.dart';
import '../../../../shared/utils/enums/gender_enum.dart';
import '../../../../shared/widgets/card_pig_presentation_widget.dart';
import '../../../model/entities/pig/pig_entity.dart';
import '../../personal_pig_page_view/personal_pig_page_view.dart';





class AllArchivedPigsPage extends StatefulWidget {
  const AllArchivedPigsPage({Key? key}) : super(key: key);

  @override
  State<AllArchivedPigsPage> createState() => _AllArchivedPigsPageState();
}

class _AllArchivedPigsPageState extends State<AllArchivedPigsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Todos os Suinos Arquivados'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      extendBody: true,
      body: BackgroundGradient(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<PigEntity>>(
                  future: context.watch<PigRepository>().getArchivedPigs(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PigEntity>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Carregando..'));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text('Nenhum Suino arquivado'),
                          )
                        : ListView(
                            children: snapshot.data!.map((pig) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalPigPageView(
                                          pigEntity: pig,
                                        ),
                                      ),
                                    );
                                  });
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
      ),
    );
  }
}
