import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';

class ImageDetail extends StatelessWidget {
  const ImageDetail({
    required this.letter,
    this.imgPath,
    super.key,
  });

  final String? imgPath;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: imgPath == null
          ? Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Palette.secondary,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 150,
                  ),
                ),
              ),
            )
          : ClipOval(
              child: Image.asset(
                imgPath!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
