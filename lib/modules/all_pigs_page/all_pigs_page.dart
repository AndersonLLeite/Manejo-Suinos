import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/modules/personal_pig_page_view/personal_pig_page_view.dart';
import 'package:provider/provider.dart';

import 'package:manejo_suinos/shared/entities/pig/pig_entity.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/themes/colors/app_colors.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';

import '../../shared/themes/styles/textstyles/app_text_styles.dart';
import '../../shared/widgets/card_pig_presentation_widget.dart';

class AllPigsPage extends StatefulWidget {
  const AllPigsPage({Key? key}) : super(key: key);

  @override
  State<AllPigsPage> createState() => _AllPigsPageState();
}

class _AllPigsPageState extends State<AllPigsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_pig');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBody: true,
      body: BackgroundGradient(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<PigEntity>>(
                  future: context.watch<PigRepository>().getActivePigs(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PigEntity>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text('Nenhum Suino cadastrado'),
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

class TextRichCardAllPigs extends StatelessWidget {
  const TextRichCardAllPigs({
    Key? key,
    required this.text,
    required this.textValue,
  }) : super(key: key);
  final String text;
  final String textValue;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$text : ',
        style: AppTextStyles.listTileTitle,
        children: [
          TextSpan(text: textValue, style: AppTextStyles.listTileTitle),
        ],
      ),
    );
  }
}
