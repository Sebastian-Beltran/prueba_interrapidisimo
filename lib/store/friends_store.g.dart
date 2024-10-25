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

  late final _$assignLocationToFriendAsyncAction =
      AsyncAction('_FriendStore.assignLocationToFriend', context: context);

  @override
  Future assignLocationToFriend(int locationId, int friendId) {
    return _$assignLocationToFriendAsyncAction
        .run(() async => super.assignLocationToFriend(locationId, friendId));
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
friends: ${friends}
    ''';
  }
}
