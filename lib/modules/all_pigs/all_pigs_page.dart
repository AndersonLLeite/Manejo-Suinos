import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/entities/pig/pig_entity.dart';
import 'package:manejo_suinos/shared/themes/colors/app_colors.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';
import 'package:manejo_suinos/shared/themes/styles/textstyles/app_text_styles.dart';
import 'package:manejo_suinos/shared/utils/popup_menu_List_Items.dart';
import 'package:manejo_suinos/shared/utils/enums/breed_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/obtained_enum.dart';
import 'package:provider/provider.dart';

import '../../data/data_helper.dart';

class AllPigsPage extends StatefulWidget {
  const AllPigsPage({Key? key}) : super(key: key);

  @override
  State<AllPigsPage> createState() => _AllPigsPageState();
}

class _AllPigsPageState extends State<AllPigsPage> {
  PopupMenuListItems _dropDownListItems = PopupMenuListItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
          ),
          child: FutureBuilder<List<PigEntity>>(
              //future: DataHelper.instance.getPigsEntity(),
              future: context.watch<DataHelper>().getPigsEntity(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PigEntity>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading...'));
                }
                return snapshot.data!.isEmpty
                    ? Center(
                        child: Text('Nenhum Suino cadastrado'),
                      )
                    : ListView(
                        children: snapshot.data!.map((pig) {
                          return Center(
                            child: Card(
                              shadowColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: AppColors.primary,
                              elevation: 20,
                              child: ListTile(
                                dense: true,
                                title: Center(
                                  child: Text(
                                    pig.name,
                                    style: AppTextStyles.listTileTitle,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(AppImages.pigs),
                                  radius: 30.0,
                                ),
                                subtitle: Icon(
                                  pig.gender == Gender.FEMALE
                                      ? Icons.female
                                      : Icons.male,
                                  color: pig.gender == Gender.FEMALE
                                      ? AppColors.secondary
                                      : AppColors.primary,
                                ),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (String newValue) {
                                    if (newValue == 'remover') {
                                      context
                                          .read<DataHelper>()
                                          .remove(pig.name);
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(newValue)));
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      _dropDownListItems.popupPigMenuItems,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
              }),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_pig');
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
        ),
        child: Text("Adicionar novo suino"),
      ),
    );
  }
}
