import 'package:flutter/material.dart';
import 'package:manejo_suinos/shared/themes/styles/textstyles/app_text_styles.dart';

class CardWarehouseWidget extends StatelessWidget {
  final String title;
  final String image;

  const CardWarehouseWidget({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 170,
        height: 170,
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
