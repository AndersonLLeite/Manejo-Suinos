import 'package:flutter/material.dart';

class TextFieldAddWeighingWidget extends StatelessWidget {
  const TextFieldAddWeighingWidget({
    Key? key,
    required this.weightController,
    required this.focusNodeWeight,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController weightController;
  final FocusNode focusNodeWeight;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
      child: TextField(
        focusNode: focusNodeWeight,
        controller: weightController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
