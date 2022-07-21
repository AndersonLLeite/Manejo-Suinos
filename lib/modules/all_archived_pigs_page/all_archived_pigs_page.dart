import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/modules/personal_pig_page_view/personal_pig_page_view.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/themes/background/background_gradient.dart';
import '../../shared/themes/colors/app_colors.dart';
import '../../shared/widgets/card_pig_presentation_widget.dart';

class AllArchivedPigsPage extends StatefulWidget {
  const AllArchivedPigsPage({Key? key}) : super(key: key);

  @override
  State<AllArchivedPigsPage> createState() => _AllArchivedPigsPageState();
}

class _AllArchivedPigsPageState extends State<AllArchivedPigsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        : GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
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
                                    color: Colors.grey, pig: pig),
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
