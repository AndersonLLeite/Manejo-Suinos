import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/event_repository/event_repository.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/shedule_utils/shedule_utils.dart';
import 'package:provider/provider.dart';

import '../../shared/entities/event/event_entity.dart';
import '../../shared/entities/pig/pig_entity.dart';
import '../../shared/themes/colors/app_colors.dart';

class EventsPigPage extends StatefulWidget {
  final PigEntity pigEntity;

  const EventsPigPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  State<EventsPigPage> createState() => _EventsPigPageState();
}

class _EventsPigPageState extends State<EventsPigPage> {
  final TextEditingController _controllerTitle = TextEditingController();

  final TextEditingController _controllerDescription = TextEditingController();

  final FocusNode _focusNodeTitle = FocusNode();

  DateTime _date = DateTime.now();
  String formattedDate =
      "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString().padLeft(4, '0')}";


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
        title: const Text('Agenda'),
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
                  'Agendamentos: ',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              FutureBuilder(
                  future: context
                      .watch<EventRepository>()
                      .getEventsByPigName(widget.pigEntity.name),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<EventEntity>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text('Nenhuma Pesagem cadastrada'),
                          )
                        : SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    snapshot.data![index].title,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].description ?? "",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  trailing: Text(
                                    formatDate(snapshot.data![index].date),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.event,
                                    color: AppColors.primary,
                                  ),
                                );
                              },
                            ),
                          );
                  }),
              widget.pigEntity.getStatus() == "ACTIVE"
                  ? ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 50),
                                              child: TextFormField(
                                                focusNode: _focusNodeTitle,
                                                controller: _controllerTitle,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Titulo*",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 50),
                                              child: TextFormField(
                                                controller:
                                                    _controllerDescription,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Descrição",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 50),
                                              child: Text(
                                                formattedDate,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 50),
                                              child: ElevatedButton(
                                                child: Text("Selecione a data"),
                                                onPressed: () async {
                                                  DateTime? newDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2020),
                                                    lastDate: DateTime(2050),
                                                  );
                                                  if (newDate != null) {
                                                    setState(() {
                                                      DateTime lastDate =
                                                          DateTime(
                                                              newDate.year,
                                                              newDate.month,
                                                              newDate.day);

                                                      _date = lastDate;
                                                      formattedDate =
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColors.secondary,
                                              ),
                                              onPressed: () {
                                                if (_controllerTitle
                                                    .text.isEmpty) {
                                                  _focusNodeTitle
                                                      .requestFocus();
                                                } else {
                                                  EventEntity event =
                                                      EventEntity(
                                                    title:
                                                        _controllerTitle.text,
                                                    description:
                                                        _controllerDescription
                                                            .text,
                                                    date: _date,
                                                    pigName:
                                                        widget.pigEntity.name,
                                                  );
                                                  List<EventEntity> events = [];
                                                  events.add(event);
                                                  setEventSource(events);
                                                  Provider.of<EventRepository>(
                                                          context,
                                                          listen: false)
                                                      .addEvent(event);
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text("Agendar"),
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
                                  ),
                                );
                              });
                            });
                      },
                      child: const Text('Novo agendamento'))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
