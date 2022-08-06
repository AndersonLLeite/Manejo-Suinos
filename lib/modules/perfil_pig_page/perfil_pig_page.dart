import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';

import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/enums/finality_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/status_enum.dart';
import 'package:manejo_suinos/shared/widgets/buttom_finality_widget.dart';
import 'package:manejo_suinos/shared/widgets/buttom_gender_widget.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/themes/colors/app_colors.dart';

class PerfilPigPage extends StatefulWidget {
  final PigEntity pigEntity;
  const PerfilPigPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  State<PerfilPigPage> createState() => _PerfilPigPageState();
}

class _PerfilPigPageState extends State<PerfilPigPage> {
  final double precoCarne = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(widget.pigEntity.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await Provider.of<PigRepository>(context, listen: false)
                    .removePig(widget.pigEntity.name);
                await Provider.of<WeighingRepository>(context, listen: false)
                    .removeWeighingByPigName(widget.pigEntity.name);
              },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                PigEntity archivedPigEntity = widget.pigEntity.copyWith(
                    status: widget.pigEntity.getStatus() == "ACTIVE"
                        ? Status.ARCHIVED.value
                        : Status.ACTIVE.value);
                await Provider.of<PigRepository>(context, listen: false)
                    .updatePig(archivedPigEntity);
              },
              icon: Icon(widget.pigEntity.getStatus() == "ACTIVE"
                  ? Icons.archive
                  : Icons.unarchive)),
        ],
      ),
      body: BackgroundGradient(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    backgroundImage:
                        Image.asset(widget.pigEntity.imageUrl).image,
                    radius: 80,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.pigEntity.gender == Gender.FEMALE.value
                          ? ButtomGenderWidget(
                              color: AppColors.secondary,
                              title: 'Fêmea',
                              icon: Icon(Icons.female))
                          : ButtomGenderWidget(
                              color: AppColors.primary,
                              title: 'Macho',
                              icon: Icon(Icons.male),
                            ),
                      ButtomFinalityWidget(
                          color: AppColors.primary,
                          title: widget.pigEntity.finality),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  height: 25,
                  width: double.maxFinite,
                  child: Center(
                    child: Text("Informações Gerais",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Nome")),
                          DataColumn(label: Text("Idade")),
                          DataColumn(label: Text("Peso")),
                          DataColumn(label: Text("Gpd")),
                          DataColumn(label: Text("Mãe")),
                          DataColumn(label: Text("Pai")),
                          DataColumn(label: Text("Obtido")),
                        ],
                        columnSpacing: 18,
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(widget.pigEntity.name)),
                            DataCell(Text(widget.pigEntity.age.toString())),
                            DataCell(Text(widget.pigEntity.weight.toString())),
                            DataCell(Text(widget.pigEntity.gpd.toString())),
                            DataCell(Text(widget.pigEntity.motherName)),
                            DataCell(Text(widget.pigEntity.fatherName)),
                            DataCell(
                                Text(widget.pigEntity.obtained.toString())),
                          ]),
                        ])),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  height: 25,
                  width: double.maxFinite,
                  child: Center(
                    child: Text("Estatísticas Econômicas",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Despesas")),
                        DataColumn(label: Text("Valor estimado ")),
                      ],
                      columnSpacing: 18,
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(
                              "${widget.pigEntity.buyValue.toStringAsFixed(2)} R\$")),
                          DataCell(Text(
                              "${(precoCarne * (widget.pigEntity.weight * 0.70)).toStringAsFixed(2)} R\$")),
                        ]),
                      ]),
                ),
                widget.pigEntity.finality != Finality.FATTEN.value
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primary,
                        ),
                        height: 25,
                        width: double.maxFinite,
                        child: Center(
                          child: Text("Estatísticas de Reprodução",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      )
                    : SizedBox(),
                widget.pigEntity.finality != Finality.FATTEN.value
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: const [
                              DataColumn(
                                label: Text("Nº filhos"),
                              ),
                              DataColumn(
                                  label: Text("Receita dos\nfilhos vendidos")),
                              DataColumn(
                                  label: Text(
                                      "Receita estimada na \nvenda dos filhos ativos")),
                            ],
                            columnSpacing: 18,
                            rows: [
                              DataRow(cells: [
                                DataCell(FutureBuilder(
                                    future: context
                                        .watch<PigRepository>()
                                        .getSons(widget.pigEntity.name),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(snapshot.data.toString());
                                      } else {
                                        return Text("0");
                                      }
                                    })),
                                DataCell(
                                  FutureBuilder(
                                      future: context
                                          .watch<PigRepository>()
                                          .getValueSonSells(
                                              widget.pigEntity.name),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              "${snapshot.data.toString()} R\$");
                                        } else {
                                          return Text("0 R\$");
                                        }
                                      }),
                                ),
                                DataCell(
                                  FutureBuilder(
                                      future: context
                                          .watch<PigRepository>()
                                          .getValueEstimateSonsActive(
                                              widget.pigEntity.name),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              "${(((snapshot.data! as double) * 0.70) * precoCarne).toStringAsFixed(2)} R\$");
                                        } else {
                                          return Text("0");
                                        }
                                      }),
                                ),
                              ]),
                            ]),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
