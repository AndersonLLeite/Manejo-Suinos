import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/view/add_pigsty_page/add_pigsty_page.dart';
import 'package:manejo_suinos/modules/view/pigsty_page/pigsty_page.dart';

import '../modules/view/add_pig_page/add_pig_page.dart';

import '../modules/view/home_page/home_page.dart';
import '../modules/view/manejo_page_view/all_archived_pigs_page/all_archived_pigs_page.dart';
import '../modules/view/manejo_page_view/all_pigs_page/all_pigs_page.dart';
import '../modules/view/manejo_page_view/manejo_page_view.dart';
import '../modules/view/schedule_page/schedule_page.dart';
import '../modules/view/vaccination_all_page/vaccination_page.dart';
import '../modules/view/vaccination_tips_page/vaccination_tips_page/vaccination_tips_page.dart';

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
        '/all_pigs': (context) => AllPigsPage(),
        '/add_pig': (context) => AddPigPage(),
        '/archive_pig': (context) => AllArchivedPigsPage(),
        '/manejo': (context) => ManejoPageView(),
        '/schedule': (context) => ShedulePage(),
        '/vaccination_page': (context) => VaccinationPage(),
        '/vaccination_tips': (context) => VaccinationTipsPage(),
        '/pigsty_page':(context) => PigstyPage(),
        '/add_pigsty':(context) => AddPigstyPage()
      },
      home: HomePage(),
    );
  }
}
