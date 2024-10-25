import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prueba_interrapidisimo/core/constants/palette.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/card_location.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_text_form_field.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/list_friends.dart';
import 'package:prueba_interrapidisimo/store/location_store.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationsScreen> {
  final locationStore = GetIt.instance<LocationStore>();
  bool isValid = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    locationStore.loadLocations();
  }

  Future<void> _checkPermissions() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied) {
      permissionStatus = await Permission.location.request();
      if (permissionStatus.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso de ubicación denegado')),
        );
      } else if (permissionStatus.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Permiso de ubicación denegado permanentemente. Por favor habilítalo desde la configuración.',
            ),
          ),
        );
        openAppSettings();
      }
    }

    if (permissionStatus.isGranted) {
      setState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ubicaciones',
      ),
      drawer: const Drawer(
        child: FriendsScreen(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: CustomTextFormField(
              prefixIcon: const Icon(Icons.search),
              controller: searchController,
              labelText: 'Buscar ubicaciones',
              onChanged: (value) => locationStore.filterLocationsByName(value),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                final locations = locationStore.filteredLocations;
                if (locations.isEmpty) {
                  return const Center(
                      child: Text('No hay ubicaciones creadas'));
                }
                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return CardLocation(
                      location: location,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isValid
          ? FloatingActionButton(
              onPressed: _navigateToCreateLocation,
              backgroundColor: Palette.primary,
              child: const Icon(
                size: 32,
                Icons.add_location_alt_outlined,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  void _navigateToCreateLocation() {
    Navigator.pushNamed(context, '/create-location');
  }
}
