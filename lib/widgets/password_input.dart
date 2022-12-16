import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onTap;
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const CustomPasswordField(
      {required this.obscureText,
      required this.onTap,
      required this.labelText,
      required this.hintText,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12,
              right: 15,
              bottom: 10,
            ),
            child: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
    );
  }
}
