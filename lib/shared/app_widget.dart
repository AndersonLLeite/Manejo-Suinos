import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/view/vaccination_program_view/vaccination_program_view.dart';

import '../modules/view/add_pig_page/add_pig_page.dart';

import '../modules/view/home_page/home_page.dart';
import '../modules/view/manejo_page_view/all_archived_pigs_page/all_archived_pigs_page.dart';
import '../modules/view/manejo_page_view/all_pigs_page/all_pigs_page.dart';
import '../modules/view/manejo_page_view/manejo_page_view.dart';
import '../modules/view/schedule_page/schedule_page.dart';
import '../modules/view/vaccination_program_view/vaccination_breeder_page/vaccination_breeder_page.dart';
import '../modules/view/vaccination_program_view/vaccination_gilts_page/vaccination_gilts_page.dart';
import '../modules/view/vaccination_program_view/vaccination_matrix_page/vaccination_matrix_page.dart';
import '../modules/view/vaccination_program_view/vaccination_piglet_page/vaccination_piglet_page.dart';
import '../modules/view/vaccination_program_view/vaccination_tips_page/vaccination_tips_page.dart';


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
        '/vaccination_piglet': (context) => VaccinationPigletPage(),
        '/vaccination_breeder': (context) => VaccinationBreederPage(),
        '/vaccination_gilts': (context) => VaccinationGiltsPage(),
        '/vaccination_matrix': (context) => VaccinationMatrixPage(),
        '/vaccination_program': (context) => VaccinationProgramView(),
        '/vaccination_tips': (context) => VaccinationTipsPage(),
      },
      home: HomePage(),
    );
  }
}
