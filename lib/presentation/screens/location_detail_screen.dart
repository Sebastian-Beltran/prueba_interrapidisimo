import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/friend_model.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_interrapidisimo/store/friends_store.dart';

class LocationDetailScreen extends StatefulWidget {
  const LocationDetailScreen({required this.location, super.key});

  final Location location;

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  final friendStore = GetIt.instance<FriendStore>();

  @override
  void initState() {
    super.initState();
    friendStore.getFriendById(widget.location.id!);
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.location;
    return Scaffold(
      appBar: CustomAppBar(title: location.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              '${location.id} Información ubicación ${location.friendId}',
              style: const TextStyle(
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
            location.friendId != null
                ? Observer(
                    builder: (context) {
                      if (friendStore.friend == null) {
                        return const Text('No hay ubicaciones asociadas');
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(friendStore.friend!.firstName),
                          IconButton(
                            onPressed: () => _navigateToAsignLocation(
                              location.id,
                            ),
                            icon: const Icon(Icons.cached_outlined),
                          ),
                        ],
                      );
                    },
                  )
                //  FutureBuilder<String>(
                //     future: fetchFriend(location.friendId!),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return const Center(child: CircularProgressIndicator());
                //       }
                //       final friend = snapshot.data!;
                //       if (friend.isEmpty) {
                //         return const Center(
                //             child: Text('No hay ubicaciones asociadas'));
                //       }
                // return Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(friend),
                //     IconButton(
                //       onPressed: () => _navigateToAsignLocation(
                //         location.id,
                //       ),
                //       icon: const Icon(Icons.cached_outlined),
                //     ),
                //   ],
                // );
                //     },
                //   )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No hay amigos asignados ${location.id}'),
                      IconButton(
                        onPressed: () => _navigateToAsignLocation(location.id),
                        icon: const Icon(Icons.add),
                      ),
                    ],
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
              child: _buildPhotoGrid(location!),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToAsignLocation(int? locationId) async {
    Navigator.pushNamed(
      context,
      '/asign-friend',
      arguments: locationId,
    );
  }

  Future<void> fetchFriend(int friendId) async {
    await friendStore.getFriendById(friendId);
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
