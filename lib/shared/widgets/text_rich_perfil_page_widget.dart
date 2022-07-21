import 'package:flutter/material.dart';

import '../themes/styles/textstyles/app_text_styles.dart';

class TextRichPerfilPageWidget extends StatelessWidget {
  const TextRichPerfilPageWidget({
    Key? key,
    required this.text,
    required this.textValue,
  }) : super(key: key);

  final String text;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: AppTextStyles.listTileTitle,
        children: [
          TextSpan(text: textValue, style: AppTextStyles.listTileTitle),
        ],
      ),
    );
  }
}