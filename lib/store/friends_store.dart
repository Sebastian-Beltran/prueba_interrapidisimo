import 'package:mobx/mobx.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/friend_model.dart';
import 'package:prueba_interrapidisimo/store/location_store.dart';
part 'friends_store.g.dart';

class FriendStore = _FriendStore with _$FriendStore;

abstract class _FriendStore with Store {
  @observable
  ObservableList<Friend> friends = ObservableList<Friend>();

  @observable
  Friend? friend;

  @action
  void addFriend(Friend friend) {
    if (friends.length >= 5) {
      throw Exception('Solo puedes agregar hasta 5 amigos');
    }
    friends.add(friend);
  }

  @action
  Future<void> getFriendById(int friendId, LocationStore locationStore) async {
    final friendDb = await DatabaseHelper.instance.getFriendById(friendId);
    if (friendDb != null) {
      friend = friendDb;
      await locationStore.loadLocations();
    } else {
      throw Exception('Usuario no encontrado');
    }
  }

  @action
  void assignLocationToFriend(
    int locationId,
    int friendId,
    LocationStore locationStore,
  ) async {
    final db = await DatabaseHelper.instance.database;
    try {
      await db.update(
        'locations',
        {'friend_id': friendId},
        where: 'id = ?',
        whereArgs: [locationId],
      );
      final updatedLocation =
          await DatabaseHelper.instance.getLocationById(locationId);
      if (updatedLocation != null) {
        locationStore.updateLocation(updatedLocation);
      }
      await getFriendById(friendId, locationStore);
    } catch (error) {
      throw Exception('Error al asignar la ubicación: $error');
    }
  }
}
