import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';
import 'package:prueba_interrapidisimo/presentation/screens/location_detail_screen.dart';

class CardLocation extends StatelessWidget {
  const CardLocation({
    required this.location,
    super.key,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetailScreen(
              location: location,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            size: 40,
          ),
          title: Text(
            location.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            location.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
