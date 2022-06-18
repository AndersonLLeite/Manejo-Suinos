import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/widgets/baia_widget.dart';

import '../../shared/widgets/corredor_widget.dart';
import '../../shared/widgets/galpao_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Galpao(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(child: BaiaWidget()),
                //Corredor(),
                Expanded(child: PisoSemBaia()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(child: BaiaWidget()),
                //Corredor(),
                Expanded(child: BaiaWidget()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(child: BaiaWidget()),
                // Corredor(),
                Expanded(child: BaiaWidget()),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PisoSemBaia extends StatelessWidget {
  const PisoSemBaia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pisoTerra.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
    );
  }
}
