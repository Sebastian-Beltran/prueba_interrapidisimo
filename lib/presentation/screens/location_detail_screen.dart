import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_interrapidisimo/store/friends_store.dart';
import 'package:prueba_interrapidisimo/store/location_store.dart';

class LocationDetailScreen extends StatefulWidget {
  const LocationDetailScreen({required this.location, super.key});

  final Location location;

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  final friendStore = GetIt.instance<FriendStore>();
  final locationStore = GetIt.instance<LocationStore>();
  int? friendIdAux;

  @override
  void initState() {
    super.initState();
    locationStore.loadLocations();
    if (widget.location.friendId != null) {
      friendStore
          .getFriendById(widget.location.friendId!, locationStore)
          .then((_) {
        setState(() {});
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar amigo: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.location;
    friendIdAux = widget.location.friendId;
    return Scaffold(
      appBar: CustomAppBar(title: location.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Información ubicación',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (location.description.isNotEmpty) Text(location.description),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lat: ${location.latitude}'),
                  Text('Lon: ${location.longitude}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Amigos asignados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Observer(
              builder: (context) {
                final friend = friendStore.friend;
                if (friend == null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No hay amigos asignados'),
                      IconButton(
                        onPressed: () => _navigateToAsignLocation(location.id),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(friend.firstName),
                    IconButton(
                      onPressed: () => _navigateToAsignLocation(location.id),
                      icon: const Icon(Icons.cached_outlined),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Fotos ubicación',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: _buildPhotoGrid(location),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToAsignLocation(int? locationId) async {
    final result = await Navigator.pushNamed(
      context,
      '/asign-friend',
      arguments: locationId,
    ) as int?;

    if (result != null) {
      friendIdAux = result;
      await locationStore.loadLocations();
      await friendStore.getFriendById(result, locationStore);
      setState(() {});
    }
    setState(() {});
  }

  Future<void> fetchFriend(int friendId) async {
    await friendStore.getFriendById(friendId, locationStore);
  }

  Widget _buildPhotoGrid(Location location) {
    if (location.photos.isEmpty) {
      return const Text('No hay fotos asociadas a esta ubicación.');
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: location.photos.length,
        itemBuilder: (context, index) {
          String photoPath = location.photos[index];
          return Image.file(
            File(photoPath),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
