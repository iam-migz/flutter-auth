import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;

  const CustomTextField(
      {required this.labelText,
      required this.hintText,
      required this.controller,
      required this.textInputType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)))),
    );
  }
}
