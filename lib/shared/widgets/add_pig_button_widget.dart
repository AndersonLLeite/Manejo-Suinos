import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/shared/entities/heighing/weighing_entity.dart';
import 'package:provider/provider.dart';

import '../entities/pig/pig_entity.dart';

class AddPigButtonWidget extends StatelessWidget {
  const AddPigButtonWidget({
    Key? key,
    required TextEditingController controllerName,
    required TextEditingController controllerAge,
    required TextEditingController controllerWeight,
    required TextEditingController controllerBuy,
    required String? gender,
    required String? finality,
    required String? obtained,
    required String motherName,
    required String fatherName,
    required this.gpd,
  })  : _controllerName = controllerName,
        _controllerAge = controllerAge,
        _controllerWeight = controllerWeight,
        _controllerBuy = controllerBuy,
        _gender = gender,
        _finality = finality,
        _obtained = obtained,
        _motherName = motherName,
        _fatherName = fatherName,
        super(key: key);

  final TextEditingController _controllerName;
  final TextEditingController _controllerAge;
  final TextEditingController _controllerWeight;
  final TextEditingController _controllerBuy;
  final double gpd;

  final String? _gender;
  final String? _finality;
  final String? _obtained;
  final String _motherName;
  final String _fatherName;

  addFirstWeighing(BuildContext context) async {
    DateTime today = DateTime.now();
    late String dateSlug =
        "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
    await Provider.of<WeighingRepository>(context, listen: false).addWeighing(
        WeighingEntity(
            name: _controllerName.text,
            date: dateSlug,
            weight: double.parse(_controllerWeight.text),
            age: int.parse(_controllerAge.text),
            gpd: gpd));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          try {
            Provider.of<PigRepository>(context, listen: false).addPig(PigEntity(
              name: _controllerName.text,
              age: int.parse(_controllerAge.text),
              weight: double.parse(_controllerWeight.text),
              gpd: gpd,
              gender: _gender!,
              finality: _finality!,
              obtained: _obtained!,
              motherName: _motherName,
              fatherName: _fatherName,
              buyValue: _controllerBuy.text.isEmpty
                  ? 0
                  : double.parse(_controllerBuy.text),
              sellValue: 0,
            ));
            addFirstWeighing(context);
            Navigator.pop(context);
          } catch (e) {
            print('error');
          }
        },
        child: Text("Adicionar Suino"));
  }
}
