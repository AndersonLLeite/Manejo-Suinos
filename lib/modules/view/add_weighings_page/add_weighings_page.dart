import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';

import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';

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
  FocusNode focusNodeWeight = FocusNode();
  final TextEditingController _weightController = TextEditingController();

  DateTime _date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _formattedDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString().padLeft(4, '0')}";
  late int _age;

  Future<double> getPigGpd() async {
    DateTime birthday =
        await PigRepository.instance.getPigBirth(widget.pigEntity.name);
    _age = _date.difference(birthday).inDays;
    int lastAge =
        await WeighingRepository.instance.getLastAge(widget.pigEntity.name);
    double lastWeight =
        await WeighingRepository.instance.getLastWeight(widget.pigEntity.name);
    double newWeight = double.parse(_weightController.text);
    double gpd;
    if (_age == lastAge) {
      gpd = 0;
    } else if (_age - lastAge != 0) {
      gpd = (newWeight - lastWeight) / (_age - lastAge);
    } else {
      gpd = (newWeight - lastWeight);
    }
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
              focusNodeWeight: focusNodeWeight,
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
            double gpd = await getPigGpd();
            if (_weightController.text.isNotEmpty) {
              try {
                await WeighingRepository.instance.addWeighing(WeighingEntity(
                    name: widget.pigEntity.name,
                    date: _date,
                    weight: double.parse(_weightController.text),
                    age: _age,
                    gpd: gpd));
                PigEntity updatedPig = widget.pigEntity.copyWith(
                    weight: double.parse(_weightController.text), gpd: gpd);
                await PigRepository.instance.updatePig(updatedPig);
                Navigator.pop(context);
              } catch (e) {
                print('error');
              }
            } else {
              focusNodeWeight.requestFocus();
            }
          },
          child: Row(
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
