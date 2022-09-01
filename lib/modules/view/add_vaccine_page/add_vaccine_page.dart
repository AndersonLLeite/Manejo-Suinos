import 'package:flutter/material.dart';

import 'package:manejo_suinos/data/vaccine_repository/vaccine_repository.dart';
import 'package:manejo_suinos/modules/model/entities/vaccine/vaccine_entity.dart';
import 'package:manejo_suinos/shared/themes/colors/app_colors.dart';
import 'package:manejo_suinos/shared/utils/enums/pigstage_enum.dart';

import '../../../data/event_repository/event_repository.dart';
import '../../../data/pig_repository/pig_repository.dart';
import '../../../shared/themes/background/background_gradient.dart';
import '../../../shared/themes/styles/textstyles/app_text_styles.dart';
import '../../../shared/utils/enums/event_type_enum.dart';
import '../../../shared/utils/shedule_utils/shedule_utils.dart';
import '../../model/entities/event/event_entity.dart';
import '../../model/entities/pig/pig_entity.dart';

class AddVaccinePage extends StatefulWidget {
  const AddVaccinePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddVaccinePage> createState() => _AddVaccinePageState();
}

class _AddVaccinePageState extends State<AddVaccinePage> {
  final TextEditingController _vaccineNameController = TextEditingController();
  final TextEditingController _vaccineDescriptionController =
      TextEditingController();
  final TextEditingController _applicationLifeDaysController =
      TextEditingController();
  final FocusNode _focusNodeVaccineName = FocusNode();
  final FocusNode _focusNodeApplDay = FocusNode();

  bool _checkBoxAll = false;
  bool _checkBoxBreeders = false;
  bool _checkBoxMatrixs = false;

  String getPigStage() {
    if (_checkBoxMatrixs) {
      return PigStage.MATRIXS.value;
    } else if (_checkBoxBreeders) {
      return PigStage.BREEDER.value;
    } else {
      return PigStage.ALL.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Text(
          'Adicionar nova vacina',
        ),
        centerTitle: true,
      ),
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 100.0, right: 100, left: 100, bottom: 8),
              child: TextFormFieldAddVaccinePage(
                focusNode: _focusNodeVaccineName,
                maxLines: 1,
                vaccineNameController: _vaccineNameController,
                label: "Nome da vacina*",
                inputType: TextInputType.text,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: TextFormFieldAddVaccinePage(
                maxLines: 4,
                vaccineNameController: _vaccineDescriptionController,
                label: "Descrição (opcional)",
                inputType: TextInputType.text,
              ),
            ),
            TitleAddVaccinePageWidget(
              title: "Grupo Da vacinação",
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: AppColors.primary,
                  value: _checkBoxAll,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxAll = value!;
                      _checkBoxBreeders = false;
                      _checkBoxMatrixs = false;
                    });
                  },
                ),
                Text("Todos"),
                Checkbox(
                  value: _checkBoxBreeders,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxAll = false;
                      _checkBoxBreeders = value!;
                      _checkBoxMatrixs = false;
                    });
                  },
                ),
                Text("Reprodutores"),
                Checkbox(
                  value: _checkBoxMatrixs,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxAll = false;
                      _checkBoxBreeders = false;
                      _checkBoxMatrixs = value!;
                    });
                  },
                ),
                Text("Matrizes"),
              ],
            ),
            Column(
              children: [
                TitleAddVaccinePageWidget(
                  title: "Idade que deve aplica-la:",
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    child: TextFormFieldAddVaccinePage(
                        focusNode: _focusNodeApplDay,
                        maxLines: 1,
                        vaccineNameController: _applicationLifeDaysController,
                        label: "Idade (em dias)",
                        inputType: TextInputType.number)),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_vaccineNameController.text.isEmpty) {
                    _focusNodeVaccineName.requestFocus();
                  } else if (_applicationLifeDaysController.text.isEmpty) {
                    _focusNodeApplDay.requestFocus();
                  } else {
                    final VaccineEntity vaccineEntity = VaccineEntity(
                        vaccineName:
                            '${_vaccineNameController.text} - ${getPigStage() == 'Engorda' ? 'Todos' : getPigStage()}',
                        description: _vaccineDescriptionController.text,
                        type: "Dose única",
                        pigStage: getPigStage(),
                        applicationLifeDays:
                            int.parse(_applicationLifeDaysController.text));

                    await VaccineRepository.instance.addVaccine(vaccineEntity);

                    List<PigEntity> pigs;
                    if (vaccineEntity.pigStage == PigStage.ALL.value) {
                      pigs = await PigRepository.instance
                          .getPigsWithAgeLessThan(
                              vaccineEntity.applicationLifeDays);
                    } else {
                      pigs = await PigRepository.instance
                          .getPigsWithAgeLessThanStage(
                              vaccineEntity.applicationLifeDays,
                              vaccineEntity.pigStage);
                    }

                    for (PigEntity pig in pigs) {
                      DateTime date = pig.birthday.add(
                          Duration(days: vaccineEntity.applicationLifeDays));
                      DateTime vaccinationDate =
                          DateTime(date.year, date.month, date.day);

                      EventEntity eventEntity = EventEntity(
                          date: vaccinationDate,
                          title: vaccineEntity.vaccineName,
                          description: vaccineEntity.description,
                          pigName: pig.name,
                          type: EventType.VACCINE.value);
                      List<EventEntity> events = [];
                      events.add(eventEntity);
                      setEventSource(events);

                      await EventRepository.instance.addEvent(eventEntity);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Adicionar vacina"))
          ]),
        ),
      ),
    );
  }
}

class TitleAddVaccinePageWidget extends StatelessWidget {
  const TitleAddVaccinePageWidget({
    Key? key,
    required this.title,
    required this.height,
  }) : super(key: key);

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(title, style: AppTextStyles.titleAddVaccinePage),
        ),
      ),
    );
  }
}

class TextFormFieldAddVaccinePage extends StatelessWidget {
  final TextEditingController vaccineNameController;
  final String label;
  final TextInputType inputType;
  final int maxLines;
  final FocusNode? focusNode;
  const TextFormFieldAddVaccinePage({
    Key? key,
    required this.vaccineNameController,
    required this.label,
    required this.inputType,
    required this.maxLines,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: inputType,
      controller: vaccineNameController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
