import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:manejo_suinos/data/pigsty_repository/pigsty_repository.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/shared/app_widget.dart';
import 'package:provider/provider.dart';

import 'data/event_repository/event_repository.dart';
import 'data/vaccine_repository/vaccine_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting().then((_) => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PigRepository.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => WeighingRepository.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => EventRepository.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => VaccineRepository.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => PigstyRepository.instance,
        ),
      ],
      child: AppWidget(),
    ),
  ));
  
}
