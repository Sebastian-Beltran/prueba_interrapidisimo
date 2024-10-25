// ignore_for_file: avoid_print

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/presentation/screens/asign_friend_location.dart';
import 'package:prueba_interrapidisimo/presentation/screens/friend_detail_screen.dart';
import 'package:prueba_interrapidisimo/presentation/screens/locations_screen.dart';
import 'package:prueba_interrapidisimo/presentation/screens/create_location_screen.dart';
import 'package:prueba_interrapidisimo/presentation/screens/location_detail_screen.dart';
import 'package:prueba_interrapidisimo/store/friends_store.dart';
import 'package:prueba_interrapidisimo/store/location_store.dart';

Future<void> main() async {
  GetIt.instance.registerLazySingleton(() => LocationStore());
  GetIt.instance.registerLazySingleton(() => FriendStore());
  runZonedGuarded<void>(() async {
    EquatableConfig.stringify = true;
    WidgetsFlutterBinding.ensureInitialized();
    await DatabaseHelper.instance.database;
    runApp(const MyApp());
  }, (error, stack) {
    print(error.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InterRapidisimo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Palette.white,
          iconTheme: const IconThemeData(),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Palette.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const LocationsScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const LocationsScreen(),
        '/create-location': (context) => const CreateLocationScreen(),
        // '/detail-location': (context) => const LocationDetailScreen(),
        '/detail-friend': (context) => const FriendDetailScreen(),
        '/asign-friend': (context) => const AsignFriendLocation(),
      },
    );
  }
}
