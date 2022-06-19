import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/allpigs/all_pigs.dart';
import 'package:manejo_suinos/modules/home/home_page.dart';

import '../modules/edit/edit_page.dart';
import '../modules/teste/teste.dart';
import '../modules/warehouse/warehouse_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manejo Suinos',
      theme: ThemeData.dark(),
      routes: {
        '/home': (context) => HomePage(),
        '/edit': (context) => EditPage(),
        '/teste': (context) => Teste(),
        '/warehouse': (context) => WarehousePage(),
        '/allpigs': (context) => AllPigs(),
      },
      home: HomePage(),
    );
  }
}
