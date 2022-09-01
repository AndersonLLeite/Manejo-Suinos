import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/styles/textstyles/app_text_styles.dart';

import '../../../../shared/themes/background/background_gradient.dart';

class VaccinationTipsPage extends StatelessWidget {
  const VaccinationTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(children: const [
            Padding(
              padding:
                  EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              child: Text(
                'Dicas de Vacinação',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
              child: Text(
                'Um programa de vacinação para ser implementado em uma granja, o técnico responsável pela assistência à granja, deverá conhecer o status sanitário da mesma, manter um programa de acompanhamento de abates, promover necrópsias com alguma regularidade, e manter um programa de monitoramento nas enfermidades já existente no rebanho e nas possíveis entradas de novos problemas sanitários na suinocultura, bem como conhecer muito bem as principais doenças que ocorrem nos suínos na região.',
                style: AppTextStyles.descriptionVaccinationTips,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
              child: Text(
                '''
        // Não vacinar animais sob condições de stress, cançados, desnutridos, parasitados, e recém chegados de viagem. As seringas e agulhas utilizadas com vacinas deverão ser novas, descartáveis ou quando seringas de vidro, deverão ser fervidas por 10 minutos antes do uso, JAMAIS use agulhas e ou seringas lavadas e desinfetadas com ALCOOL e ou desinfetantes, pois estará inativando a vacina.
        
        // Os animais que forem vacinados deverão estar bem de saúde e não estarem apresentando febre, inapetência, vomitando ou com sintomas de alguma doença. Observar as recomendações como carência da vacinação até o abate do animal, (normalmente 21 dias).
        
        // Observar as condições de armazenamento e transporte das vacinas sempre, refrigeradas entre 2º a 6º graus. Não congelar, e agitar o frasco da vacina antes de encher a seringa. E uma vez aberto o frasco, procure vacinar naquele momento todos os animais e evitar guardar frascos de vacinas com sobras. E estar sempre atento que o uso de produto biológico (vacinas) em alguns casos poderá provocar choque anafilático, e deverá ter à mão Epinefrina, ou um sucedâneo para evitar a morte de um animal vacinado.

  
        ''',
                style: AppTextStyles.descriptionVaccinationTips,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
