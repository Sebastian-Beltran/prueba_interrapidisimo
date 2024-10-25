import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_button.dart';
import 'package:prueba_interrapidisimo/presentation/widgets/custom_text_form_field.dart';
import 'package:prueba_interrapidisimo/store/location_store.dart';
import 'package:geolocator/geolocator.dart';

class CreateLocationScreen extends StatefulWidget {
  const CreateLocationScreen({
    super.key,
  });

  @override
  State<CreateLocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<CreateLocationScreen> {
  final locationStore = GetIt.instance<LocationStore>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> photos = [];
  bool isLoading = false;
  Position? _position;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        if (photos.length < 3) {
          photos.add(pickedImage.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Solo puedes agregar hasta 3 fotos',
              ),
            ),
          );
        }
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _position = position;
      });
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addLocation() async {
    if (nameController.text.isEmpty || photos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'El nombre y al menos una foto son requeridos.',
          ),
        ),
      );
      return;
    }
    await _getCurrentLocation();
    try {
      if (_position != null) {
        final location = Location(
          name: nameController.text,
          latitude: _position!.latitude,
          longitude: _position!.longitude,
          description: descriptionController.text,
          photos: photos,
        );
        await locationStore.addLocation(location);
        nameController.clear();
        descriptionController.clear();
        setState(() {
          photos = [];
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Ubicación agregada exitosamente',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Agregar Ubicación'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CustomTextFormField(
              labelText: 'Nombre',
              controller: nameController,
              onChanged: (s) {},
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              labelText: 'Descripción',
              controller: descriptionController,
              onChanged: (s) {},
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _pickImage,
              text: 'Tomar Foto',
            ),
            const SizedBox(height: 60),
            Observer(
              builder: (_) => Wrap(
                children: photos
                    .map((photo) =>
                        Image.file(File(photo), width: 100, height: 100))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    onPressed: _addLocation,
                    text: 'Agregar ubicación',
                  ),
          ],
        ),
      ),
    );
  }
}
