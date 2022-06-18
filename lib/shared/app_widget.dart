import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/home/home_page.dart';

import '../modules/edit/edit_page.dart';
import '../modules/teste/teste.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manejo Suinos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/edit': (context) => EditPage(),
        '/teste': (context) => Teste(),
      },
      home: HomePage(),
    );
  }
}
