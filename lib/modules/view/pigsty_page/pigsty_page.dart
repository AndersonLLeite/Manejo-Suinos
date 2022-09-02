import 'package:flutter/material.dart';

import 'package:manejo_suinos/modules/model/entities/pigsty/pigsty_entity.dart';

class PigstyPage extends StatefulWidget {
  final PigstyEntity pigstyEntity;
  const PigstyPage({
    Key? key,
    required this.pigstyEntity,
  }) : super(key: key);

  @override
  State<PigstyPage> createState() => _PigstyPageState();
}

class _PigstyPageState extends State<PigstyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baia - ${widget.pigstyEntity.pigstyName}'),
      ),
      body: Container(),
    );
  }
}
