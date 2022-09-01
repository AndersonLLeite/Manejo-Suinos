import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/event_repository/event_repository.dart';
import 'package:manejo_suinos/data/vaccine_repository/vaccine_repository.dart';
import 'package:manejo_suinos/modules/model/entities/vaccine/vaccine_entity.dart';
import 'package:manejo_suinos/shared/utils/enums/obtained_enum.dart';
import 'package:provider/provider.dart';

import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';

import '../../modules/model/entities/event/event_entity.dart';
import '../../modules/model/entities/heighing/weighing_entity.dart';
import '../../modules/model/entities/pig/pig_entity.dart';
import '../utils/enums/event_type_enum.dart';
import '../utils/shedule_utils/shedule_utils.dart';

class AddPigButtonWidget extends StatelessWidget {
  const AddPigButtonWidget({
    Key? key,
    required this.controllerName,
    required this.controllerAge,
    required this.controllerWeight,
    required this.controllerBuy,
    required this.gpd,
    this.gender,
    this.finality,
    this.obtained,
    required this.motherName,
    required this.fatherName,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controllerName;
  final TextEditingController controllerAge;
  final TextEditingController controllerWeight;
  final TextEditingController controllerBuy;
  final double gpd;
  final String? gender;
  final String? finality;
  final String? obtained;
  final String motherName;
  final String fatherName;
  final FocusNode? focusNode;

  DateTime getBirthday() {
    return DateTime.now()
        .subtract(Duration(days: int.parse(controllerAge.text)));
  }

  double calcGpd() {
    int age = DateTime.now().difference(getBirthday()).inDays;
    return double.parse(controllerWeight.text) / age;
  }

  addFirstWeighing() async {
    DateTime today = DateTime.now();

    await WeighingRepository.instance.addWeighing(WeighingEntity(
        name: controllerName.text,
        date: today,
        weight: double.parse(controllerWeight.text),
        age: int.parse(controllerAge.text),
        gpd: calcGpd()));
  }

  addVaccinesEvents(PigEntity pig) async {
    List<VaccineEntity> listVaccines = await VaccineRepository.instance
        .getVaccinesByDayAndFinality(pig.age, pig.finality);
    for (final vaccine in listVaccines) {
      EventEntity eventEntity = EventEntity(
          date: pig.birthday.add(Duration(days: vaccine.applicationLifeDays)),
          title: vaccine.vaccineName,
          description: vaccine.description,
          pigName: pig.name,
          type: EventType.VACCINE.value);
      await EventRepository.instance.addEvent(eventEntity);
      List<EventEntity> events = [];
      events.add(eventEntity);
      setEventSource(events);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (obtained == Obtained.PURCHASED.value &&
              controllerBuy.text.isEmpty) {
            focusNode!.requestFocus();
          } else {
            try {
              PigEntity pigEntity = PigEntity(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  weight: double.parse(controllerWeight.text),
                  gpd: calcGpd(),
                  gender: gender!,
                  finality: finality!,
                  obtained: obtained!,
                  motherName: motherName,
                  fatherName: fatherName,
                  buyValue: controllerBuy.text.isEmpty
                      ? 0
                      : double.parse(controllerBuy.text),
                  sellValue: 0,
                  birthday: getBirthday());

              PigRepository.instance.addPig(pigEntity);

              addFirstWeighing();
              addVaccinesEvents(pigEntity);
              Navigator.pop(context);
            } catch (e) {
              print('error');
            }
          }
        },
        child: Text("Adicionar Suino"));
  }
}
