import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';

part 'location_store.g.dart';

class LocationStore = _LocationStore with _$LocationStore;

abstract class _LocationStore with Store {
  @observable
  ObservableList<Location> locations = ObservableList<Location>();

  @action
  Future<void> addLocation(Location location) async {
    if (locations.any((loc) =>
        loc.name == location.name ||
        Geolocator.distanceBetween(loc.latitude, loc.longitude,
                location.latitude, location.longitude) <
            500)) {
      throw Exception('Ubicación demasiado cercana o nombre duplicado');
    }

    if (location.photos.length > 3) {
      throw Exception('Solo puedes agregar hasta 3 fotos');
    }
    await DatabaseHelper.instance.createLocation(location);
    await loadLocations();
  }

  @action
  Future<void> loadLocations() async {
    final dbLocations = await DatabaseHelper.instance.getAllLocations();
    locations.clear();
    locations.addAll(dbLocations);
  }
}
