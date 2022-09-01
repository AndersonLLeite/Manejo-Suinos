import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/pigsty_repository/pigsty_repository.dart';
import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';

import '../../../shared/themes/colors/app_colors.dart';

class PigstyPage extends StatefulWidget {
  const PigstyPage({Key? key}) : super(key: key);

  @override
  State<PigstyPage> createState() => _PigstyPageState();
}

class _PigstyPageState extends State<PigstyPage> {
  final FocusNode _focusNodePigstyName = FocusNode();
  final TextEditingController _controllerName = TextEditingController();
  bool _checkBoxMaternity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text('Baias'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        body: BackgroundGradient(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: PigstyRepository.instance.getAllPigsty(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PigstyEntity>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('Loading...'));
                      }
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: Text('Nenhum Suino cadastrado'),
                            )
                          : ListView(
                              children: snapshot.data!.map((pigsty) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Text(pigsty.name),
                                );
                              }).toList(),
                            );
                    })
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 38, horizontal: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => Padding(
                          padding: EdgeInsets.all(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primary,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      child: TextFormField(
                                        focusNode: _focusNodePigstyName,
                                        maxLength: 11,
                                        controller: _controllerName,
                                        decoration: InputDecoration(
                                          icon:
                                              Icon(Icons.other_houses_outlined),
                                          hintText: "Nome da baia",
                                          border: OutlineInputBorder(),
                                          labelText: "Nome da baia",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text("Selecione o tipo de baia"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Checkbox(
                                            value: _checkBoxMaternity,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkBoxMaternity = true;
                                              });
                                            }),
                                        Text("Maternidade"),
                                        Checkbox(
                                            value: _checkBoxMaternity,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkBoxMaternity = true;
                                              });
                                            }),
                                        Text("Creche"),
                                        Checkbox(
                                            value: _checkBoxMaternity,
                                            onChanged: (value) {
                                              setState(() {
                                                _checkBoxMaternity = true;
                                              });
                                            }),
                                        Text("Engorda"),
                                      ],
                                    )
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
                                        onPressed: () {},
                                        child: Text("Criar")),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.secondary,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancelar")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(flex: 1, child: Icon(Icons.add)),
                        Expanded(flex: 2, child: Text("Adicionar Nova baia")),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
