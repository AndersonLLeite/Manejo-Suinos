import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/styles/textstyles/app_text_styles.dart';

class CardHomePageWidget extends StatelessWidget {
  final String title;
  final String image;

  const CardHomePageWidget({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(image),
            ),
            Expanded(
              flex: 1,
              child: Text(title, style: AppTextStyles.titleCardWarehouseWidget),
            ),
          ],
        ),
      ),
    );
  }
}
