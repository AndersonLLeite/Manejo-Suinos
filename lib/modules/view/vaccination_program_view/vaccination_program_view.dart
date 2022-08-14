import 'package:flutter/material.dart';
import 'package:manejo_suinos/modules/view/vaccination_program_view/vaccination_breeder_page/vaccination_breeder_page.dart';
import 'package:manejo_suinos/modules/view/vaccination_program_view/vaccination_gilts_page/vaccination_gilts_page.dart';
import 'package:manejo_suinos/modules/view/vaccination_program_view/vaccination_matrix_page/vaccination_matrix_page.dart';
import 'package:manejo_suinos/modules/view/vaccination_program_view/vaccination_piglet_page/vaccination_piglet_page.dart';
import 'package:manejo_suinos/modules/view/vaccination_program_view/vaccination_tips_page/vaccination_tips_page.dart';



class VaccinationProgramView extends StatefulWidget {

  const VaccinationProgramView({ Key? key }) : super(key: key);

  @override
  State<VaccinationProgramView> createState() => _VaccinationProgramViewState();
}

class _VaccinationProgramViewState extends State<VaccinationProgramView> {
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
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye_outlined), label: 'Leitões'),
          BottomNavigationBarItem(
              icon: Icon(Icons.present_to_all_sharp), label: 'Marrãs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Matrizes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Reprodutores'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Dicas'),
          
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: setPageView,
        children: const [VaccinationPigletPage(), VaccinationGiltsPage(), VaccinationMatrixPage(), VaccinationBreederPage(), VaccinationTipsPage()],
      ),
    );
  }
}