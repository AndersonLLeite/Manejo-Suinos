import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/event_repository/event_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';
import 'package:manejo_suinos/shared/utils/enums/event_type_enum.dart';
import 'package:manejo_suinos/shared/utils/enums/finality_enum.dart';
import 'package:manejo_suinos/shared/utils/shedule_utils/shedule_utils.dart';
import 'package:provider/provider.dart';

import '../../../../shared/themes/colors/app_colors.dart';
import '../../../model/entities/event/event_entity.dart';
import '../../../model/entities/pig/pig_entity.dart';

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

  DateTime _date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
                  style: TextStyle(fontSize: 20),
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
                            child: Text('Nenhuma Agendamento marcado'),
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
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    "Tem certeza que deseja excluir este agendamento?"),
                                                
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        if (widget.pigEntity
                                                                .isPregnant ==
                                                            1) {
                                                          PigRepository.instance
                                                              .updatePig(widget
                                                                  .pigEntity
                                                                  .copyWith(
                                                                      isPregnant:
                                                                          0));
                                                        }
                                                        EventRepository.instance
                                                            .deleteEvent(
                                                                snapshot.data![
                                                                    index]);
                                                        deleteEventToSource(
                                                            snapshot
                                                                .data![index]);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Excluir")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancelar")),
                                                ],
                                              ));
                                    },
                                    color: AppColors.secondary,
                                  ),
                                  leading: Column(
                                    children: [
                                      Icon(
                                        snapshot.data![index].type ==
                                                EventType.COBERTURA.value
                                            ? Icons.child_friendly
                                            : snapshot.data![index].type ==
                                                    EventType.VACCINE.value
                                                ? Icons.vaccines
                                                : Icons.event,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        formatDate(snapshot.data![index].date),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
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
                                  padding: const EdgeInsets.only(
                                      top: 0, bottom: 20, left: 20, right: 20),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
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
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2100),
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
                                                  EventEntity event = EventEntity(
                                                      title:
                                                          _controllerTitle.text,
                                                      description:
                                                          _controllerDescription
                                                              .text,
                                                      date: _date,
                                                      pigName:
                                                          widget.pigEntity.name,
                                                      type: EventType
                                                          .OTHER.value);
                                                  List<EventEntity> events = [];
                                                  events.add(event);
                                                  setEventSource(events);
                                                  EventRepository.instance
                                                      .addEvent(event);
                                                  _controllerDescription
                                                      .clear();
                                                  _controllerTitle.clear();
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
              widget.pigEntity.getStatus() == "ACTIVE" &&
                      widget.pigEntity.finality == Finality.MATRIX.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 50),
                      child: ElevatedButton(
                        child: Text("Informar cobertura da matriz"),
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        bottom: 20,
                                        left: 20,
                                        right: 20),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 20,
                                          left: 10,
                                          right: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
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
                                                child: Text(
                                                  formattedDate,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 50),
                                                child: ElevatedButton(
                                                  child: Text(
                                                      "Selecione a data da cobertura"),
                                                  onPressed: () async {
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2100),
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
                                                  EventEntity event = EventEntity(
                                                      title:
                                                          "Previsão de parto",
                                                      description:
                                                          "Provavel data para o parto da matriz coberta",
                                                      date: _date.add(
                                                          Duration(days: 114)),
                                                      pigName:
                                                          widget.pigEntity.name,
                                                      type: EventType
                                                          .COBERTURA.value);
                                                  List<EventEntity> events = [];
                                                  events.add(event);
                                                  setEventSource(events);
                                                  Provider.of<EventRepository>(
                                                          context,
                                                          listen: false)
                                                      .addEvent(event);
                                                  _controllerDescription
                                                      .clear();
                                                  _controllerTitle.clear();
                                                  Provider.of<PigRepository>(
                                                          context,
                                                          listen: false)
                                                      .updatePig(widget
                                                          .pigEntity
                                                          .copyWith(
                                                              isPregnant: 1));
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Confirmar"),
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
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
