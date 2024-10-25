import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/friend_model.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
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
    return Column(
      children: [
        const SizedBox(height: 80),
        const Text(
          'Amigos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        friends.isEmpty
            ? const CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final friend = friends[index];
                    return ListTile(
                      leading: friend.photo == null
                          ? Container(
                              width: 30,
                              height: 30,
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
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                      title: Text('${friend.firstName} ${friend.lastName}'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/detail-friend',
                        arguments: friend,
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
