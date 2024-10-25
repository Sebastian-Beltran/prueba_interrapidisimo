import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/friend_model.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_app_bar.dart';

class AsignFriendLocation extends StatefulWidget {
  const AsignFriendLocation({super.key});

  @override
  State<AsignFriendLocation> createState() => _AsignFriendLocationState();
}

class _AsignFriendLocationState extends State<AsignFriendLocation> {
  List<Friend> friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    final dbFriends = await DatabaseHelper.instance.getFriends();
    setState(() {
      friends = dbFriends;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Asignar amigo'),
      body: Column(
        children: [
          const SizedBox(height: 80),
          friends.isEmpty
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.all(20),
                        leading: friend.photo == null
                            ? Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Palette.secondary,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    friend.firstName.substring(0, 1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            : ClipOval(
                                child: Image.asset(
                                  friend.photo!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        title: Text(
                          '${friend.firstName} ${friend.lastName}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(friend.email),
                        onTap: () => assignLocation(locationId, friend.id!),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> assignLocation(int locationId, int friendId) async {
    final location = await DatabaseHelper.instance
        .assignLocationToFriend(locationId, friendId);
    Navigator.pop(context, location);
  }
}
