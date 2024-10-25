import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  });

  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Palette.primary : Colors.grey,
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text,
          style: TextStyle(
            color: isEnabled ? Colors.white : Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
