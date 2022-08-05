import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/utility_image/utility_image.dart';
import 'package:manejo_suinos/shared/widgets/add_pig_buttom_widget.dart';
import 'package:manejo_suinos/shared/widgets/buttom_finality_widget.dart';
import 'package:manejo_suinos/shared/widgets/buttom_gender_widget.dart';
import 'package:manejo_suinos/shared/widgets/card_pig_parents.dart';
import 'package:manejo_suinos/shared/widgets/form_add_pig_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/themes/colors/app_colors.dart';
import '../../shared/themes/images/app_images.dart';
import '../../shared/themes/styles/textstyles/app_text_styles.dart';
import '../../shared/utils/enums/finality_enum.dart';
import '../../shared/utils/enums/obtained_enum.dart';
import '../../shared/widgets/button_obtained_widget.dart';
import '../../shared/widgets/card_breed_widget.dart';
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
  Color colorButtomBreed = AppColors.defaultColorButtomDisabled;
  double sliderValue = 0.0;
  PigEntity? motherSelected;
  PigEntity? fatherSelected;
  bool breedSelected = false;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _gender;
  String? _finality;
  String? _obtained;
  String _motherName = 'Indefinido';
  String _fatherName = 'Indefinido';
  String? _breed;

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

  _defineColorAllButtomDisabled() {
    colorButtomFinalityFatten = AppColors.defaultColorButtomDisabled;
    colorButtomFinalityMatrix = AppColors.defaultColorButtomDisabled;
    colorButtomFinalityBreeder = AppColors.defaultColorButtomDisabled;
    colorButtomObtainedBorn = AppColors.defaultColorButtomDisabled;
    colorButtomObtainedPurchased = AppColors.defaultColorButtomDisabled;
    _finality = null;
    _obtained = null;
    _fatherName = "Indefinido";
    _motherName = "Indefinido";
    _breed = null;
  }

  final List<CardBreedWidget> _listCardBreed = [
    CardBreedWidget(
      title: 'Duroc',
      image: AppImages.duroc,
    ),
    CardBreedWidget(
      title: 'Pietrain',
      image: AppImages.pietrain,
    ),
    CardBreedWidget(
      title: 'hampshire',
      image: AppImages.hampshire,
    ),
    CardBreedWidget(
      title: 'Landrace',
      image: AppImages.landrace,
    ),
  ];

  // File? image;
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() {
  //       this.image = imageTemporary;
  //       imageUrl = UtilityImage.base64String(imageTemporary.readAsBytesSync());
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to picl image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped image');
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: Image.asset(AppImages.pig).image,
                    ),
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
              ]),
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
                        _gender = Gender.MALE.value;
                        if (_finality != null) {
                          _defineColorAllButtomDisabled();
                        }
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
                        _gender = Gender.FEMALE.value;
                        if (_finality != null) {
                          _defineColorAllButtomDisabled();
                        }
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
              colorButtomGenderMale != AppColors.defaultColorButtomDisabled ||
                      colorButtomGenderFemale !=
                          AppColors.defaultColorButtomDisabled
                  ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Selecione a finalidade',
                        style: AppTextStyles.primaryTitleAddPig,
                      ),
                    )
                  : SizedBox(),
              colorButtomGenderMale != AppColors.defaultColorButtomDisabled ||
                      colorButtomGenderFemale !=
                          AppColors.defaultColorButtomDisabled
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _defineColorButtomFinalityFatten();
                              _finality = Finality.FATTEN.value;
                            });
                          },
                          child: ButtomFinalityWidget(
                              color: colorButtomFinalityFatten,
                              title: 'Engorda'),
                        ),
                        colorButtomGenderMale == AppColors.primary
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _defineColorButtomFinalityBreeder();
                                    _finality = Finality.BREEDER.value;
                                  });
                                },
                                child: ButtomFinalityWidget(
                                    color: colorButtomFinalityBreeder,
                                    title: 'Reprodutor'),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _defineColorButtomFinalityMatrix();
                                    _finality = Finality.MATRIX.value;
                                  });
                                },
                                child: ButtomFinalityWidget(
                                    color: colorButtomFinalityMatrix,
                                    title: 'Matriz'),
                              ),
                      ],
                    )
                  : SizedBox(),
              colorButtomFinalityFatten !=
                          AppColors.defaultColorButtomDisabled ||
                      colorButtomFinalityBreeder !=
                          AppColors.defaultColorButtomDisabled ||
                      colorButtomFinalityMatrix !=
                          AppColors.defaultColorButtomDisabled
                  ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Selecione a origem',
                        style: AppTextStyles.primaryTitleAddPig,
                      ),
                    )
                  : SizedBox(),
              colorButtomFinalityFatten !=
                          AppColors.defaultColorButtomDisabled ||
                      colorButtomFinalityBreeder !=
                          AppColors.defaultColorButtomDisabled ||
                      colorButtomFinalityMatrix !=
                          AppColors.defaultColorButtomDisabled
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _defineColorButtomObtainedPurchased();
                              _obtained = Obtained.PURCHASED.value;
                            });
                          },
                          child: ButtonObtainedWidget(
                              color: colorButtomObtainedPurchased,
                              title: 'Comprado'),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _defineColorButtomObtainedBorn();
                              _obtained = Obtained.BORN.value;
                            });
                          },
                          child: ButtonObtainedWidget(
                              color: colorButtomObtainedBorn,
                              title: 'Nascido aqui'),
                        ),
                      ],
                    )
                  : SizedBox(),
              _obtained == Obtained.BORN.value
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text('Selecione a mãe do suino ',
                              style: AppTextStyles.primaryTitleAddPig),
                        ),
                        FutureBuilder<List<PigEntity>>(
                            future: context.watch<PigRepository>().getMatrix(),
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
                                      child: motherSelected == null
                                          ? ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children:
                                                  snapshot.data!.map((pig) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _motherName = pig.name;
                                                      motherSelected = pig;
                                                    });
                                                  },
                                                  child: CardPigParent(
                                                      color:
                                                          AppColors.secondary,
                                                      pig: pig),
                                                );
                                              }).toList(),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CardPigParent(
                                                  color: AppColors.secondary,
                                                  pig: motherSelected!,
                                                ),
                                                IconButton(
                                                  iconSize: 40,
                                                  icon: Icon(
                                                    Icons.refresh,
                                                    color: AppColors.secondary,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _motherName =
                                                          'Indefinido';
                                                      motherSelected = null;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                    );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text('Selecione o pai do suino ',
                              style: AppTextStyles.primaryTitleAddPig),
                        ),
                        FutureBuilder<List<PigEntity>>(
                            future: context.watch<PigRepository>().getBreeder(),
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
                                      child: fatherSelected == null
                                          ? ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children:
                                                  snapshot.data!.map((pig) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _fatherName = pig.name;
                                                      fatherSelected = pig;
                                                    });
                                                  },
                                                  child: CardPigParent(
                                                      color: AppColors.primary,
                                                      pig: pig),
                                                );
                                              }).toList(),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CardPigParent(
                                                  color: AppColors.primary,
                                                  pig: fatherSelected!,
                                                ),
                                                IconButton(
                                                  iconSize: 40,
                                                  icon: Icon(
                                                    Icons.refresh,
                                                    color: AppColors.primary,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _fatherName =
                                                          'Indefinido';
                                                      fatherSelected = null;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                    );
                            }),
                        (motherSelected != null && fatherSelected != null) ||
                                breedSelected
                            ? AddPigButtomWidget(
                                controllerName: _controllerName,
                                controllerAge: _controllerAge,
                                controllerWeight: _controllerWeight,
                                gpd: 0.0,
                                gender: _gender,
                                finality: _finality,
                                obtained: _obtained,
                                motherName: _motherName,
                                fatherName: _fatherName)
                            : SizedBox()
                      ],
                    )
                  : SizedBox(),
              _obtained == Obtained.PURCHASED.value
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text('Selecione a raça',
                              style: AppTextStyles.primaryTitleAddPig),
                        ),
                        SizedBox(
                            height: 250,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: _listCardBreed.map((breed) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _breed = breed.title;
                                        breedSelected = true;
                                        print(breed.title);
                                      });
                                    },
                                    child: CardBreedWidget(
                                      title: breed.title,
                                      image: breed.image,
                                    ));
                              }).toList(),
                            )),
                      ],
                    )
                  : SizedBox(),
              breedSelected
                  ? AddPigButtomWidget(
                      controllerName: _controllerName,
                      controllerAge: _controllerAge,
                      controllerWeight: _controllerWeight,
                      gpd: 0.0,
                      gender: _gender,
                      finality: _finality,
                      obtained: _obtained,
                      motherName: _motherName,
                      fatherName: _fatherName)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
