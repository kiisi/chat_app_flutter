import 'package:flutter/material.dart';
import 'package:chat_app/utils/textfield_styles.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool hasAsterisks;

  LoginTextField(
      {required this.hintText,
      this.validator,
      required this.controller,
      this.hasAsterisks = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hasAsterisks,
      validator: (value) {
        if (validator != null) return validator!(value);
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ThemeTextStyle.loginTextFieldStyle,
        border: OutlineInputBorder(),
      ),
    );
  }
}
