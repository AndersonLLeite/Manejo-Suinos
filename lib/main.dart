import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/weighing_repository/weighing_repository.dart';
import 'package:manejo_suinos/data/pig_repository/pig_repository.dart';
import 'package:manejo_suinos/shared/app_widget.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PigRepository.instance),
        ChangeNotifierProvider(create: (_) => WeighingRepository.instance),
      ],
      child: AppWidget(),
    ),
  );
}
