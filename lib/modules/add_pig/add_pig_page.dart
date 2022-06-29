import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/data_helper.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/popup_menu_List_Items.dart';
import 'package:manejo_suinos/shared/widgets/buttom_finality_widget.dart';
import 'package:manejo_suinos/shared/widgets/buttom_gender_widget.dart';
import 'package:manejo_suinos/shared/widgets/form_add_pig_widget.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/themes/colors/app_colors.dart';
import '../../shared/themes/styles/textstyles/app_text_styles.dart';
import '../../shared/utils/enums/finality_enum.dart';
import '../../shared/utils/enums/obtained_enum.dart';
import '../../shared/widgets/button_obtained_widget.dart';
import '../../shared/widgets/card_pig_presentation_widget.dart';

class AddPigPage extends StatefulWidget {
  const AddPigPage({Key? key}) : super(key: key);

  @override
  State<AddPigPage> createState() => _AddPigPageState();
}

class _AddPigPageState extends State<AddPigPage> {
  Color colorButtomGenderMale = AppColors.defaultColorButtomDisabled;
  Color colorButtomGenderFemale = AppColors.defaultColorButtomDisabled;
  Color colorButtomFinalityFatten = AppColors.defaultColorButtomDisabled;
  Color colorButtomFinalityMatrix = AppColors.defaultColorButtomDisabled;
  Color colorButtomFinalityBreeder = AppColors.defaultColorButtomDisabled;
  Color colorButtomObtainedPurchased = AppColors.defaultColorButtomDisabled;
  Color colorButtomObtainedBorn = AppColors.defaultColorButtomDisabled;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();
  String? _motherName;
  String? _fatherName;
  String? _gender;
  String? _breed;
  String? _obtained;
  String? _finality;

  _defineColorButtomGenderMale() {
    colorButtomGenderMale = AppColors.primary;
    colorButtomGenderFemale = AppColors.defaultColorButtomDisabled;
  }

  _defineColorButtomGenderFemale() {
    colorButtomGenderFemale = AppColors.secondary;
    colorButtomGenderMale = AppColors.defaultColorButtomDisabled;
  }

  _defineColorButtomFinalityFatten() {
    colorButtomFinalityFatten = AppColors.primary;
    colorButtomFinalityMatrix = AppColors.defaultColorButtomDisabled;
    colorButtomFinalityBreeder = AppColors.defaultColorButtomDisabled;
  }

  _defineColorButtomFinalityMatrix() {
    colorButtomFinalityMatrix = AppColors.secondary;
    colorButtomFinalityFatten = AppColors.defaultColorButtomDisabled;
    colorButtomFinalityBreeder = AppColors.defaultColorButtomDisabled;
  }

  _defineColorButtomFinalityBreeder() {
    colorButtomFinalityBreeder = AppColors.primary;
    colorButtomFinalityMatrix = AppColors.defaultColorButtomDisabled;
    colorButtomFinalityFatten = AppColors.defaultColorButtomDisabled;
  }

  _defineColorButtomObtainedPurchased() {
    colorButtomObtainedPurchased = AppColors.primary;
    colorButtomObtainedBorn = AppColors.defaultColorButtomDisabled;
  }

  _defineColorButtomObtainedBorn() {
    colorButtomObtainedBorn = AppColors.secondary;
    colorButtomObtainedPurchased = AppColors.defaultColorButtomDisabled;
  }

  PopupMenuListItems dropDownListItems = PopupMenuListItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: Image.asset('assets/images/pigs.png').image,
                ),
              ),
              Text(
                'adicionar foto',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Divider(
                height: 5,
              ),
              FormAddPigWidget(
                controllerName: _controllerName,
                labelText: 'Nome',
                hintText: 'Digite o nome do suino',
                icon: Icon(Icons.person),
                keyboardType: TextInputType.name,
              ),
              FormAddPigWidget(
                controllerName: _controllerAge,
                labelText: 'Idade',
                hintText: 'Digite a idade do suino em dias',
                icon: Icon(Icons.view_agenda),
                keyboardType: TextInputType.number,
              ),
              FormAddPigWidget(
                controllerName: _controllerWeight,
                labelText: 'Peso',
                hintText: 'Digite o peso atual do suino',
                icon: Icon(Icons.wallet),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Selecione o Gênero',
                  style: AppTextStyles.primaryTitleAddPig,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _defineColorButtomGenderMale();
                        _gender = Gender.MALE;
                      });
                    },
                    child: ButtomGenderWidget(
                      color: colorButtomGenderMale,
                      title: 'Macho',
                      icon: Icon(Icons.male),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _defineColorButtomGenderFemale();
                        _gender = Gender.FEMALE;
                      });
                    },
                    child: ButtomGenderWidget(
                      color: colorButtomGenderFemale,
                      title: 'Fêmea',
                      icon: Icon(Icons.female),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Selecione a finalidade',
                  style: AppTextStyles.primaryTitleAddPig,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _defineColorButtomFinalityFatten();
                        _finality = Finality.FATTEN;
                      });
                    },
                    child: ButtomFinalityWidget(
                        color: colorButtomFinalityFatten, title: 'Engorda'),
                  ),
                  colorButtomGenderMale == AppColors.primary
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _defineColorButtomFinalityBreeder();
                              _finality = Finality.BREEDER;
                            });
                          },
                          child: ButtomFinalityWidget(
                              color: colorButtomFinalityBreeder,
                              title: 'Reprodutor'),
                        )
                      : SizedBox(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _defineColorButtomFinalityMatrix();
                        _finality = Finality.MATRIX;
                      });
                    },
                    child: ButtomFinalityWidget(
                        color: colorButtomFinalityMatrix, title: 'Matriz'),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Selecione a origem',
                  style: AppTextStyles.primaryTitleAddPig,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _defineColorButtomObtainedPurchased();
                        _obtained = Obtained.PURCHASED;
                      });
                    },
                    child: ButtonObtainedWidget(
                        color: colorButtomObtainedPurchased, title: 'Comprado'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _defineColorButtomObtainedBorn();
                        _obtained = Obtained.BORN;
                      });
                    },
                    child: ButtonObtainedWidget(
                        color: colorButtomObtainedBorn, title: 'Nascido aqui'),
                  ),
                ],
              ),
              _obtained == Obtained.BORN
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text('Selecione a mãe do suino ',
                              style: AppTextStyles.primaryTitleAddPig),
                        ),
                        FutureBuilder<List<PigEntity>>(
                            future: context.watch<DataHelper>().getMatrix(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<PigEntity>> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: Text('Loading...'));
                              }
                              return snapshot.data!.isEmpty
                                  ? Center(
                                      child: Text('Nenhum Suino cadastrado'),
                                    )
                                  : SizedBox(
                                      height: 150,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        children: snapshot.data!.map((pig) {
                                          return CardPigPresentationWidget(
                                              color: AppColors.secondary,
                                              pig: pig);
                                        }).toList(),
                                      ),
                                    );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text('Selecione o pai do suino ',
                              style: AppTextStyles.primaryTitleAddPig),
                        ),
                        FutureBuilder<List<PigEntity>>(
                            future: context.watch<DataHelper>().getBreeder(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<PigEntity>> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: Text('Loading...'));
                              }
                              return snapshot.data!.isEmpty
                                  ? Center(
                                      child: Text('Nenhum Suino cadastrado'),
                                    )
                                  : SizedBox(
                                      height: 150,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        children: snapshot.data!.map((pig) {
                                          return CardPigPresentationWidget(
                                              color: AppColors.primary,
                                              pig: pig);
                                        }).toList(),
                                      ),
                                    );
                            }),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
