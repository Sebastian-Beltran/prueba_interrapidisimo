import 'package:equatable/equatable.dart';

class Location extends Equatable {
  Location({
    this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.photos,
    this.friendId,
  }) {
    if (photos.length > 3) {
      throw Exception('Una ubicación no puede tener más de 3 fotos');
    }
  }
  final int? id;
  final String name;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> photos;
  final int? friendId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'photos': photos.join(','),
      'friend_id': friendId,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      description: map['description'],
      photos: (map['photos'] as String).split(','),
      friendId: map['friend_id'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        description,
        photos,
        friendId,
      ];
}
