import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/card_location.dart';

class ListLocationsFriend extends StatelessWidget {
  const ListLocationsFriend({
    required this.friendId,
    super.key,
  });

  final int friendId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Location>>(
      future: DatabaseHelper.instance.getLocationsForFriend(friendId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final locations = snapshot.data!;
        if (locations.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            child: Center(
              child: Column(
                children: [
                  Text('No hay ubicaciones asociadas'),
                  Icon(
                    Icons.location_off_outlined,
                    size: 80,
                  )
                ],
              ),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return CardLocation(location: location);
            },
          ),
        );
      },
    );
  }
}
