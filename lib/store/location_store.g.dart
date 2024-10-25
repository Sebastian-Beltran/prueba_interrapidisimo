// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on _LocationStore, Store {
  late final _$locationsAtom =
      Atom(name: '_LocationStore.locations', context: context);

  @override
  ObservableList<Location> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(ObservableList<Location> value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$addLocationAsyncAction =
      AsyncAction('_LocationStore.addLocation', context: context);

  @override
  Future<void> addLocation(Location location) {
    return _$addLocationAsyncAction.run(() => super.addLocation(location));
  }

  late final _$loadLocationsAsyncAction =
      AsyncAction('_LocationStore.loadLocations', context: context);

  @override
  Future<void> loadLocations() {
    return _$loadLocationsAsyncAction.run(() => super.loadLocations());
  }

  @override
  String toString() {
    return '''
locations: ${locations}
    ''';
  }
}
