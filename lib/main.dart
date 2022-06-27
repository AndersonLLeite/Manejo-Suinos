
import 'package:flutter/material.dart';
import 'package:manejo_suinos/data/data_helper.dart';
import 'package:manejo_suinos/shared/app_widget.dart';
import 'package:manejo_suinos/shared/entities/pig/pig_entity.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataHelper.instance),
      ],
      child: AppWidget(),
    ),
   );
}

