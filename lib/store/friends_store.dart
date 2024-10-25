import 'package:mobx/mobx.dart';
import 'package:prueba_interrapidisimo/core/db/db_helper.dart';
import 'package:prueba_interrapidisimo/data/models/friend_model.dart';
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
  Future<void> getFriendById(int friendId) async {
    final friendDb = await DatabaseHelper.instance.getFriendById(friendId);
    if (friendDb != null) {
      friend = friendDb;
    } else {
      throw Exception('Usuario no encontrado');
    }
  }

  @action
  void assignLocationToFriend(int locationId, int friendId) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'locations',
      {'friend_id': friendId},
      where: 'id = ?',
      whereArgs: [locationId],
    );
  }
}
