import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  const Friend({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.photo,
  });
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? photo;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'photo_path': photo,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      photo: map['photo_path'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        photo,
      ];
}
