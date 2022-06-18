import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/widgets/pigsty_widget.dart';
import 'package:manejo_suinos/shared/widgets/floor_without_pigsty.dart';

import '../../shared/widgets/warehouse_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Warehouse(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(child: Pigsty()),
                //Corredor(),
                Expanded(child: FloorWithoutPigsty()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(child: Pigsty()),
                //Corredor(),
                Expanded(child: Pigsty()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(child: Pigsty()),
                // Corredor(),
                Expanded(child: Pigsty()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
