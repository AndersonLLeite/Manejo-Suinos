import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/utils/enums/obtained_enum.dart';
import 'package:provider/provider.dart';

import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';

import '../../modules/model/entities/heighing/weighing_entity.dart';
import '../../modules/model/entities/pig/pig_entity.dart';

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

  addFirstWeighing(BuildContext context) async {
    DateTime today = DateTime.now();

    await Provider.of<WeighingRepository>(context, listen: false).addWeighing(
        WeighingEntity(
            name: controllerName.text,
            date: today,
            weight: double.parse(controllerWeight.text),
            age: int.parse(controllerAge.text),
            gpd: gpd));
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
              PigRepository.instance.addPig(PigEntity(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  weight: double.parse(controllerWeight.text),
                  gpd: gpd,
                  gender: gender!,
                  finality: finality!,
                  obtained: obtained!,
                  motherName: motherName,
                  fatherName: fatherName,
                  buyValue: controllerBuy.text.isEmpty
                      ? 0
                      : double.parse(controllerBuy.text),
                  sellValue: 0,
                  birthday: DateTime.now().subtract(
                      Duration(days: int.parse(controllerAge.text)))));
              addFirstWeighing(context);
              Navigator.pop(context);
            } catch (e) {
              print('error');
            }
          }
        },
        child: Text("Adicionar Suino"));
  }
}
