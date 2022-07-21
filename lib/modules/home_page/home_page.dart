import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/colors/app_colors.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';

import '../../shared/widgets/card_homepage_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/manejo');
                  },
                  child: CardHomePageWidget(
                    title: 'Todos os Suinos',
                    image: AppImages.pigs,
                  ),
                ),
                CardHomePageWidget(
                  title: 'Economia',
                  image: AppImages.pigBank,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CardHomePageWidget(
                  title: 'Amojada',
                  image: AppImages.pregnant,
                ),
                CardHomePageWidget(
                  title: 'Agenda',
                  image: AppImages.agenda,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
