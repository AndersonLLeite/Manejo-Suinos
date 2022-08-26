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
  final TextEditingController _vaccineUnicApplication = TextEditingController();
  final TextEditingController _vaccineFirstApplicationController =
      TextEditingController();
  final TextEditingController _vaccinePeriodicApplicationController =
      TextEditingController();

  bool _checkBoxUnicValue = false;
  bool _checkBoxPeriodicValue = false;
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
              title: "Tipo de vacinação",
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dose única"),
                Checkbox(
                  activeColor: AppColors.primary,
                  value: _checkBoxUnicValue,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxUnicValue = value!;
                      _checkBoxPeriodicValue = false;
                    });
                  },
                ),
                Text("Periodico"),
                Checkbox(
                  value: _checkBoxPeriodicValue,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxPeriodicValue = value!;
                      _checkBoxUnicValue = false;
                    });
                  },
                ),
              ],
            ),
            TitleAddVaccinePageWidget(
              title: "Grupo Da vacinação",
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Todos"),
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
                Text("Reprodutores"),
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
                Text("Matrizes"),
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
              ],
            ),
            _checkBoxUnicValue
                ? Column(
                    children: [
                      TitleAddVaccinePageWidget(
                        title: "Idade que deve aplica-la:",
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          child: TextFormFieldAddVaccinePage(
                              maxLines: 1,
                              vaccineNameController: _vaccineUnicApplication,
                              label: "Idade (em dias)",
                              inputType: TextInputType.number)),
                    ],
                  )
                : SizedBox(),
            _checkBoxPeriodicValue
                ? Column(
                    children: [
                      TitleAddVaccinePageWidget(
                        title: "Idade deve aplica-la pela primeira vez:",
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          child: TextFormFieldAddVaccinePage(
                            maxLines: 1,
                            vaccineNameController:
                                _vaccineFirstApplicationController,
                            label: "Idade (em dias)",
                            inputType: TextInputType.number,
                          )),
                      TitleAddVaccinePageWidget(
                          title: "Com quantos dias será repetido", height: 30),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          child: TextFormFieldAddVaccinePage(
                            maxLines: 1,
                            vaccineNameController:
                                _vaccinePeriodicApplicationController,
                            label: "Após quantos dias",
                            inputType: TextInputType.number,
                          )),
                    ],
                  )
                : SizedBox(),
            ElevatedButton(
                onPressed: () async {
                  final VaccineEntity vaccineEntity = VaccineEntity(
                      vaccineName:
                          '${_vaccineNameController.text} - ${getPigStage()}',
                      description: _vaccineDescriptionController.text,
                      type: "Dose única",
                      pigStage: getPigStage(),
                      firstApplicationLifeDays:
                          int.parse(_vaccineUnicApplication.text));

                  await VaccineRepository.instance.addVaccine(vaccineEntity);

                  List<PigEntity> pigs;
                  if (vaccineEntity.pigStage == PigStage.ALL.value) {
                    pigs = await PigRepository.instance.getPigsWithAgeLessThan(
                        vaccineEntity.firstApplicationLifeDays);
                  } else {
                    pigs = await PigRepository.instance
                        .getPigsWithAgeLessThanStage(
                            vaccineEntity.firstApplicationLifeDays,
                            vaccineEntity.pigStage);
                  }
                  for (PigEntity pig in pigs) {
                    EventEntity eventEntity = EventEntity(
                        date: DateTime.now()
                            .subtract(Duration(days: pig.age))
                            .add(Duration(
                                days: vaccineEntity.firstApplicationLifeDays)),
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
  const TextFormFieldAddVaccinePage({
    Key? key,
    required this.vaccineNameController,
    required this.label,
    required this.inputType,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
