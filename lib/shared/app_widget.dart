import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/all_pigs/all_pigs_page.dart';
import 'package:manejo_suinos/modules/home/home_page.dart';

import '../modules/add_pig/add_pig_page.dart';
import '../modules/edit/edit_page.dart';
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
        '/warehouse': (context) => WarehousePage(),
        '/all_pigs': (context) => AllPigsPage(),
        '/add_pig': (context) => AddPigPage(),
      },
      home: HomePage(),
    );
  }
}
