import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/widgets/status_perfil_page_widget.dart';
import 'package:provider/provider.dart';

import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/enums/finality_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/gender_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/status_enum.dart';
import 'package:manejo_suinos/shared/widgets/button_finality_widget.dart';
import 'package:manejo_suinos/shared/widgets/button_gender_widget.dart';

import '../../../../shared/themes/colors/app_colors.dart';
import '../../../../shared/widgets/button_action_pig_perfil_page.dart';
import '../../../model/entities/pig/pig_entity.dart';





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
  final TextEditingController _controllerSellValue = TextEditingController();
  final double precoCarne = 12.0;
  String? reason;

  final List<String> _menuItens = ['Venda', 'Morte'];
  final FocusNode _focusNodeFirstModal = FocusNode();
  final FocusNode _focusNodeSecondModal = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(widget.pigEntity.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<PigRepository>(context, listen: false)
                    .removePig(widget.pigEntity.name);
                Provider.of<WeighingRepository>(context, listen: false)
                    .removeWeighingByPigName(widget.pigEntity.name);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete)),
          IconButton(onPressed: () async {}, icon: Icon(Icons.edit)),
        ],
      ),
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 100, right: 8, left: 8, bottom: 25),
                child: Row(
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
                              ? ButtonGenderWidget(
                                  color: AppColors.secondary,
                                  title: 'Fêmea',
                                  icon: Icon(Icons.female))
                              : ButtonGenderWidget(
                                  color: AppColors.primary,
                                  title: 'Macho',
                                  icon: Icon(Icons.male),
                                ),
                          ButtonFinalityWidget(
                              color: AppColors.primary,
                              title: widget.pigEntity.finality),
                        ],
                      ),
                    ),
                    widget.pigEntity.getStatus() == "ARCHIVED"
                        ? StatusPerfilPageWidget(
                            color: widget.pigEntity.sellValue > 0
                                ? AppColors.sellColor
                                : AppColors.deathColor,
                            title: widget.pigEntity.sellValue > 0
                                ? 'Venda'
                                : 'Morto',
                            icon: widget.pigEntity.sellValue > 0
                                ? Icon(Icons.attach_money)
                                : Icon(Icons.health_and_safety_outlined),
                          )
                        : SizedBox(),
                    widget.pigEntity.getStatus() != "ARCHIVED" &&
                            widget.pigEntity.isPregnant == 1
                        ? StatusPerfilPageWidget(
                            color: AppColors.secondary,
                            title: 'Prenhez',
                            icon: Icon(Icons.child_friendly_rounded))
                        : SizedBox(),
                  ],
                ),
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
                              DataCell(
                                  Text(widget.pigEntity.weight.toString())),
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
                        columns: [
                          DataColumn(label: Text("Despesas")),
                          DataColumn(
                              label: widget.pigEntity.getStatus() == "ACTIVE"
                                  ? Text("Valor estimado ")
                                  : Text("Receita")),
                        ],
                        columnSpacing: 18,
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(
                                "${widget.pigEntity.buyValue.toStringAsFixed(2)} R\$")),
                            DataCell(Text(widget.pigEntity.getStatus() ==
                                    "ACTIVE"
                                ? "${(precoCarne * (widget.pigEntity.weight * 0.70)).toStringAsFixed(2)} R\$"
                                : "${widget.pigEntity.sellValue.toStringAsFixed(2)}   R\$")),
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
                                    label:
                                        Text("Receita dos\nfilhos vendidos")),
                                DataColumn(
                                    label: Text(
                                        "Receita estimada na \nvenda dos filhos ativos")),
                              ],
                              columnSpacing: 18,
                              rows: [
                                DataRow(cells: [
                                  DataCell(FutureBuilder(
                                      future: Provider.of<PigRepository>(
                                              context,
                                              listen: false)
                                          .getNumberOfChildren(
                                              widget.pigEntity.name),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(snapshot.data.toString());
                                        } else {
                                          return Text("0");
                                        }
                                      })),
                                  DataCell(
                                    FutureBuilder(
                                        future: Provider.of<PigRepository>(
                                                context,
                                                listen: false)
                                            .getValueChildrenSells(
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
                                        future: Provider.of<PigRepository>(
                                                context,
                                                listen: false)
                                            .getValueEstimateChildrenActive(
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
              Row(
                children: [
                  ButtonActionPigPerfilPage(
                      pigEntity: widget.pigEntity,
                      title: widget.pigEntity.getStatus() == "ACTIVE"
                          ? "Arquivar"
                          : "Desarquivar",
                      icon: Icon(widget.pigEntity.getStatus() == "ACTIVE"
                          ? Icons.archive
                          : Icons.unarchive),
                      onPressed: () async {
                        if (widget.pigEntity.getStatus() ==
                            Status.ARCHIVED.value) {
                          PigEntity archivedPigEntity = widget.pigEntity
                              .copyWith(
                                  status: Status.ACTIVE.value, sellValue: 0);
                          Provider.of<PigRepository>(context, listen: false)
                              .updatePig(archivedPigEntity);
                          Navigator.pop(context);
                        } else {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primary,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Selecione o motivo do arquivamento"),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 8),
                                            child: DropdownButtonFormField(
                                              isExpanded: true,
                                              focusNode: _focusNodeFirstModal,
                                              decoration: InputDecoration(
                                                labelText: "Selecione",
                                                labelStyle: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              items: _menuItens.map((reason) {
                                                return DropdownMenuItem(
                                                  value: reason,
                                                  child: Text(reason),
                                                );
                                              }).toList(),
                                              onChanged: (String? newReason) {
                                                setState(() {
                                                  reason = newReason!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.secondary,
                                            ),
                                            onPressed: () {
                                              if (reason == "Morte") {
                                                Provider.of<PigRepository>(
                                                        context,
                                                        listen: false)
                                                    .updatePig(widget.pigEntity
                                                        .copyWith(
                                                  status: Status.ARCHIVED.value,
                                                ));
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              } else if (reason == "Venda") {
                                                Navigator.pop(context);
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              25.0),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    "Informe o valor da venda"),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          50,
                                                                      vertical:
                                                                          8),
                                                                  child:
                                                                      TextFormField(
                                                                    focusNode:
                                                                        _focusNodeSecondModal,
                                                                    controller:
                                                                        _controllerSellValue,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          "Valor",
                                                                      labelStyle: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary:
                                                                        AppColors
                                                                            .secondary,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    if (_controllerSellValue
                                                                        .text
                                                                        .isNotEmpty) {
                                                                      Provider.of<PigRepository>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .updatePig(widget
                                                                              .pigEntity
                                                                              .copyWith(
                                                                        status: Status
                                                                            .ARCHIVED
                                                                            .value,
                                                                        sellValue:
                                                                            double.parse(_controllerSellValue.text),
                                                                      ));
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      _focusNodeSecondModal
                                                                          .requestFocus();
                                                                    }
                                                                    // _focusNode.requestFocus();
                                                                  },
                                                                  child: Text(
                                                                      "Vender(arquivar)"),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary:
                                                                        AppColors
                                                                            .secondary,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "Cancelar"),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                );
                                              } else {
                                                _focusNodeFirstModal
                                                    .requestFocus();
                                              }
                                              // _focusNode.requestFocus();
                                            },
                                            child: Text("Arquivar"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.secondary,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancelar"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
