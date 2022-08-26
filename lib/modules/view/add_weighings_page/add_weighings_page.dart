import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';

import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/shedule_utils/shedule_utils.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/text_field_add_weighing_widget.dart';
import '../../model/entities/heighing/weighing_entity.dart';
import '../../model/entities/pig/pig_entity.dart';

class AddWeighingsPage extends StatefulWidget {
  final PigEntity pigEntity;
  const AddWeighingsPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  State<AddWeighingsPage> createState() => _AddWeighingsPageState();
}

class _AddWeighingsPageState extends State<AddWeighingsPage> {
  final TextEditingController _weightController = TextEditingController();

  DateTime _date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _formattedDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString().padLeft(4, '0')}";
  late int _age;
  Future<double> getPigGpd(BuildContext context) async {
    
    DateTime birthday = await Provider.of<PigRepository>(context, listen: false)
            .getPigBirth(widget.pigEntity.name);
    int idade = _date.difference(birthday).inDays;
    int lastAge = await Provider.of<WeighingRepository>(context, listen: false)
         .getLastAge(widget.pigEntity.name);
    // int newAge = (int.parse(_ageController.text));

    double lastWeight =
        await Provider.of<WeighingRepository>(context, listen: false)
            .getLastWeight(widget.pigEntity.name);
    double newWeight = double.parse(_weightController.text);

    double gpd = (newWeight - lastWeight) / (idade - lastAge);

    gpd = double.parse(gpd.toStringAsFixed(2));
    return gpd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Adiciona novo peso'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: BackgroundGradient(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.pigEntity.name,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              child: Text(
                _formattedDate,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              child: ElevatedButton(
                child: Text("Selecione a data"),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (newDate != null) {
                    setState(() {
                      DateTime lastDate =
                          DateTime(newDate.year, newDate.month, newDate.day);

                      _date = lastDate;
                      _formattedDate =
                          "${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year.toString().padLeft(4, '0')}";
                    });
                  } else {
                    return;
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () async {
            double gpd = await getPigGpd(context);
            try {
              await Provider.of<WeighingRepository>(context, listen: false)
                  .addWeighing(WeighingEntity(
                      name: widget.pigEntity.name,
                      date: _date,
                      weight: double.parse(_weightController.text),
                      age: _age,
                      gpd: gpd));
              PigEntity updatedPig = widget.pigEntity.copyWith(
                  weight: double.parse(_weightController.text),
                  gpd: gpd);
              await Provider.of<PigRepository>(context, listen: false)
                  .updatePig(updatedPig);
              Navigator.pop(context);
            } catch (e) {
              print('error');
            }
          },
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(flex: 1, child: Icon(Icons.add)),
              Expanded(flex: 2, child: Text("Adicionar pesagem")),
            ],
          ),
        ),
      ),
    );
  }
}
