import 'package:flutter/material.dart';
import 'package:prueba_interrapidisimo/data/models/friend_model.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/image_detail.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/list_locations_friend.dart';

class FriendDetailScreen extends StatelessWidget {
  const FriendDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friend = ModalRoute.of(context)!.settings.arguments as Friend;

    return Scaffold(
      appBar: CustomAppBar(title: '${friend.firstName} ${friend.lastName}'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            ImageDetail(
              imgPath: friend.photo,
              letter: friend.firstName.substring(0, 1),
            ),
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.mail_outline,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        friend.email,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        friend.phoneNumber,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const Text(
              'Ubicaciones asociadas ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (friend.id != null)
              ListLocationsFriend(
                friendId: friend.id!,
              ),
          ],
        ),
      ),
    );
  }
}
