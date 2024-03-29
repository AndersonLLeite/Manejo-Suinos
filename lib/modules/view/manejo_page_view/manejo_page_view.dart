import 'package:flutter/material.dart';

import 'all_archived_pigs_page/all_archived_pigs_page.dart';
import 'all_pigs_page/all_pigs_page.dart';
import 'manejo_page/manejo_page.dart';




class ManejoPageView extends StatefulWidget {
  const ManejoPageView({Key? key}) : super(key: key);

  @override
  State<ManejoPageView> createState() => _ManejoPageViewState();
}

class _ManejoPageViewState extends State<ManejoPageView> {
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
              icon: Icon(Icons.remove_red_eye_outlined), label: 'manejo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.present_to_all_sharp), label: 'Suinos ativos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Suinos arquivados'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: setPageView,
        children: const [ManejoPage(), AllPigsPage(), AllArchivedPigsPage()],
      ),
    );
  }
}
