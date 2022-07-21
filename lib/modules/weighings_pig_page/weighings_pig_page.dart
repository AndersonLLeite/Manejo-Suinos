import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/shared/entities/heighing_entity/weighing_entity.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/pig/pig_entity.dart';
import '../add_weighings_page/add_weighings_page.dart';

class WeighingsPigPage extends StatefulWidget {
  final PigEntity pigEntity;
  const WeighingsPigPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  State<WeighingsPigPage> createState() => _WeighingsPigPageState();
}

class _WeighingsPigPageState extends State<WeighingsPigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Pesagens  ${widget.pigEntity.name}'),
        centerTitle: true,
      ),
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120.0,
              ),
              const Center(
                child: Text(
                  'Histórico de Pesagens',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              FutureBuilder(
                  future: context
                      .watch<WeighingRepository>()
                      .getWeighings(widget.pigEntity.name),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<WeighingEntity>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text('Nenhuma Pesagem cadastrada'),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Idade')),
                                  DataColumn(label: Text('Data')),
                                  DataColumn(label: Text('Peso')),
                                  DataColumn(label: Text('GPD')),
                                  DataColumn(label: Text('     -')),
                                ],
                                columnSpacing: 18,
                                rows: [
                                  for (final weighing in snapshot.data!)
                                    DataRow(
                                      cells: [
                                        DataCell(Text(weighing.age.toString())),
                                        DataCell(
                                            Text(weighing.date.toString())),
                                        DataCell(
                                            Text(weighing.weight.toString())),
                                        DataCell(Text(weighing.gpd.toString())),
                                        DataCell(
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.black),
                                            onPressed: () {
                                              Provider.of<WeighingRepository>(
                                                      context,
                                                      listen: false)
                                                  .removeWeighing(
                                                      weighing.age,
                                                      weighing.date,
                                                      weighing.weight);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                ]),
                          );
                  }),
              widget.pigEntity.getStatus() == "ACTIVE"
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddWeighingsPage(
                                    pigEntity: widget.pigEntity)));
                      },
                      child: const Text('Adicionar nova pesagem'))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
