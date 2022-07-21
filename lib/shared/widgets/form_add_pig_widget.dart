import 'package:flutter/material.dart';

class FormAddPigWidget extends StatelessWidget {
  final TextEditingController controllerName;
  final String labelText;
  final String hintText;
  final Icon icon;
  final TextInputType keyboardType;
  const FormAddPigWidget({
    Key? key,
    required this.controllerName,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextFormField(
        maxLength: 11,
        keyboardType: keyboardType,
        controller: controllerName,
        onChanged: (value) {
        },
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
