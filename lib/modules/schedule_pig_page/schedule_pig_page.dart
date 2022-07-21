import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/background/background_gradient.dart';

import '../../shared/entities/pig/pig_entity.dart';

class SchedulePigPage extends StatelessWidget {
  final PigEntity pigEntity;

  const SchedulePigPage({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Agenda'),
        
      ),
      body: BackgroundGradient(
        child: Container(),
      ),
    );
  }
}
