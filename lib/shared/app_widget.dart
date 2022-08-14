import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/all_archived_pigs_page/all_archived_pigs_page.dart';
import 'package:manejo_suinos/modules/all_pigs_page/all_pigs_page.dart';
import 'package:manejo_suinos/modules/home_page/home_page.dart';
import 'package:manejo_suinos/modules/manejo_page_view/manejo_page_view.dart';
import 'package:manejo_suinos/modules/schedule_page/schedule_page.dart';

import '../modules/add_pig_page/add_pig_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manejo Suinos',
      theme: ThemeData.dark(),
      routes: {
        '/home': (context) => HomePage(),
        '/warehouse': (context) => HomePage(),
        '/all_pigs': (context) => AllPigsPage(),
        '/add_pig': (context) => AddPigPage(),
        '/archive_pig': (context) => AllArchivedPigsPage(),
        '/manejo': (context) => ManejoPageView(),
        '/schedule': (context) => ShedulePage(),
      },
      home: HomePage(),
    );
  }
}
