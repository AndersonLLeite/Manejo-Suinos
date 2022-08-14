import 'package:flutter/material.dart';


import '../../model/entities/pig/pig_entity.dart';
import '../events_pig_page/events_pig_page.dart';
import '../perfil_pig_page/perfil_pig_page.dart';
import '../weighings_pig_page/weighings_pig_page.dart';

class PersonalPigPageView extends StatefulWidget {
  final PigEntity pigEntity;
  const PersonalPigPageView({
    Key? key,
    required this.pigEntity,
  }) : super(key: key);

  @override
  State<PersonalPigPageView> createState() => _PersonalPigPageViewState();
}

class _PersonalPigPageViewState extends State<PersonalPigPageView> {
  int selectedIndex = 0;
  late PageController _pagecontroller;

  @override
  void initState() {
    _pagecontroller = PageController(initialPage: selectedIndex);
    super.initState();
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pagecontroller.animateToPage(index,
        duration: Duration(microseconds: 400), curve: Curves.ease);
  }

  setPageView(pagina) {
    setState(() {
      selectedIndex = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.transparent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.balance), label: 'Pesagens'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Agendamentos'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: setPageView,
        children: [
          PerfilPigPage(pigEntity: widget.pigEntity),
          WeighingsPigPage(pigEntity: widget.pigEntity),
          EventsPigPage(pigEntity: widget.pigEntity),
        ],
      ),
    );
  }
}
