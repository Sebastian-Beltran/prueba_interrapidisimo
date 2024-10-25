import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.bottom,
    required this.title,
    this.leading,
    super.key,
  });

  final PreferredSizeWidget? bottom;
  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      leading: leading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          ClipOval(
            child: Image.network(
              'https://avatars.githubusercontent.com/u/68518930?v=4',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Palette.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.wifi_off,
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    if (bottom == null) {
      return const Size.fromHeight(56);
    }
    return Size.fromHeight(56.0 + bottom!.preferredSize.height);
  }
}
