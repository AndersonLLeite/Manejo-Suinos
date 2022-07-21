import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/shared/entities/heighing_entity/weighing_entity.dart';

import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/widgets/text_field_add_weighing_widget.dart';

class AddWeighingsPage extends StatelessWidget {
  final PigEntity pigEntity;
  AddWeighingsPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  final TextEditingController _weightController = TextEditingController();
  DateTime today = DateTime.now();
  late String dateSlug =
      "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
  late final TextEditingController _dateController =
      TextEditingController(text: dateSlug);
  late final TextEditingController _ageController = TextEditingController();

  Future<double> getPigGpd(BuildContext context) async {
    int lastAge = await Provider.of<WeighingRepository>(context, listen: false)
        .getLastAge(pigEntity.name);
    int newAge = (int.parse(_ageController.text));
    double lastWeight =
        await Provider.of<WeighingRepository>(context, listen: false)
            .getLastWeight(pigEntity.name);
    double newWeight = double.parse(_weightController.text);

    double gpd = (newWeight - lastWeight) / (newAge - lastAge);

    gpd = double.parse(gpd.toStringAsFixed(2));
    return gpd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar novo peso'),
      ),
      body: BackgroundGradient(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pigEntity.name,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            TextFieldAddWeighingWidget(
              weightController: _weightController,
              labelText: "Novo peso",
              hintText: "Digite o novo peso",
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFieldAddWeighingWidget(
              weightController: _dateController,
              labelText: "Data",
              hintText: "Digite a data",
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFieldAddWeighingWidget(
              weightController: _ageController,
              labelText: "Idade",
              hintText: "Digite a idade atual",
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            double gpd = await getPigGpd(context);
            try {
              await Provider.of<WeighingRepository>(context, listen: false)
                  .addWeighing(WeighingEntity(
                      name: pigEntity.name,
                      date: _dateController.text,
                      weight: double.parse(_weightController.text),
                      age: int.parse(_ageController.text),
                      gpd: gpd));
              PigEntity updatedPig = pigEntity.copyWith(
                  age: int.parse(_ageController.text),
                  weight: double.parse(_weightController.text),
                  gpd: gpd);
              await Provider.of<PigRepository>(context, listen: false)
                  .updatePig(updatedPig);
              Navigator.pop(context);
            } catch (e) {
              print('error');
            }
          },
          child: Text(
            "Adicionar pesagem",
          )),
    );
  }
}
