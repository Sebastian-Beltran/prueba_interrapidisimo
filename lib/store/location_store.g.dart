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

  late final _$filteredLocationsAtom =
      Atom(name: '_LocationStore.filteredLocations', context: context);

  @override
  ObservableList<Location> get filteredLocations {
    _$filteredLocationsAtom.reportRead();
    return super.filteredLocations;
  }

  @override
  set filteredLocations(ObservableList<Location> value) {
    _$filteredLocationsAtom.reportWrite(value, super.filteredLocations, () {
      super.filteredLocations = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_LocationStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
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

  late final _$_LocationStoreActionController =
      ActionController(name: '_LocationStore', context: context);

  @override
  void filterLocationsByName(String query) {
    final _$actionInfo = _$_LocationStoreActionController.startAction(
        name: '_LocationStore.filterLocationsByName');
    try {
      return super.filterLocationsByName(query);
    } finally {
      _$_LocationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locations: ${locations},
filteredLocations: ${filteredLocations},
searchQuery: ${searchQuery}
    ''';
  }
}
