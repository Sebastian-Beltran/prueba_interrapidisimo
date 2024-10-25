// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendStore on _FriendStore, Store {
  late final _$friendsAtom =
      Atom(name: '_FriendStore.friends', context: context);

  @override
  ObservableList<Friend> get friends {
    _$friendsAtom.reportRead();
    return super.friends;
  }

  @override
  set friends(ObservableList<Friend> value) {
    _$friendsAtom.reportWrite(value, super.friends, () {
      super.friends = value;
    });
  }

  late final _$friendAtom = Atom(name: '_FriendStore.friend', context: context);

  @override
  Friend? get friend {
    _$friendAtom.reportRead();
    return super.friend;
  }

  @override
  set friend(Friend? value) {
    _$friendAtom.reportWrite(value, super.friend, () {
      super.friend = value;
    });
  }

  late final _$getFriendByIdAsyncAction =
      AsyncAction('_FriendStore.getFriendById', context: context);

  @override
  Future<void> getFriendById(int friendId, LocationStore locationStore) {
    return _$getFriendByIdAsyncAction
        .run(() => super.getFriendById(friendId, locationStore));
  }

  late final _$assignLocationToFriendAsyncAction =
      AsyncAction('_FriendStore.assignLocationToFriend', context: context);

  @override
  Future assignLocationToFriend(
      int locationId, int friendId, LocationStore locationStore) {
    return _$assignLocationToFriendAsyncAction.run(() async =>
        super.assignLocationToFriend(locationId, friendId, locationStore));
  }

  late final _$_FriendStoreActionController =
      ActionController(name: '_FriendStore', context: context);

  @override
  void addFriend(Friend friend) {
    final _$actionInfo = _$_FriendStoreActionController.startAction(
        name: '_FriendStore.addFriend');
    try {
      return super.addFriend(friend);
    } finally {
      _$_FriendStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
friends: ${friends},
friend: ${friend}
    ''';
  }
}
