import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.labelText,
    required this.controller,
    required this.onChanged,
    this.isPassword = false,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color.fromARGB(255, 238, 238, 238),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Palette.primary,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Palette.primary,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 238, 238, 238),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
