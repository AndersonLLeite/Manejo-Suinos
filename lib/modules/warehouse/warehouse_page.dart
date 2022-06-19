import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/images/app_images.dart';

import '../../shared/widgets/card_warehouse_widget.dart';

class WarehousePage extends StatefulWidget {
  const WarehousePage({Key? key}) : super(key: key);

  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: const [
              Colors.blue,
              Colors.pink,
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
                    Navigator.pushNamed(context, '/allpigs');
                  },
                  child: CardWarehouseWidget(
                    title: 'Todos os Suinos',
                    image: AppImages.pigs,
                  ),
                ),
                CardWarehouseWidget(
                  title: 'Economia',
                  image: AppImages.pigBank,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CardWarehouseWidget(
                  title: 'Amojada',
                  image: AppImages.pregnant,
                ),
                CardWarehouseWidget(
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
