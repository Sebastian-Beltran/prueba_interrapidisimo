import 'package:prueba_interrapidisimo/data/models/friend_model.dart';
import 'package:prueba_interrapidisimo/data/models/location_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('locations.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 13, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE friends (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name TEXT NOT NULL,
      last_name TEXT NOT NULL,
      email TEXT NOT NULL,
      phone_number TEXT NOT NULL,
      photo_path TEXT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE locations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      description TEXT NOT NULL,
      photos TEXT NOT NULL,
      friend_id INTEGER,
      FOREIGN KEY (friend_id) REFERENCES friends (id) ON DELETE SET NULL
    )
    ''');

    await _insertInitialFriends(db);
  }

  Future<void> _insertInitialFriends(Database db) async {
    const List<Friend> initialFriends = [
      Friend(
        firstName: 'Camilo',
        lastName: 'Lizarazo',
        email: 'camilo.l@test.com',
        phoneNumber: '+57 300 123 4101',
        photo: 'assets/img/user_1.jpeg',
      ),
      Friend(
        firstName: 'Andrea',
        lastName: 'Puentes',
        email: 'andrea.p@test.com',
        phoneNumber: '+57 300 123 4202',
        photo: 'assets/img/user_2.jpg',
      ),
      Friend(
        firstName: 'Carlos',
        lastName: 'Bernal',
        email: 'carlos.b@test.com',
        phoneNumber: '+57 300 123 4303',
        photo: 'assets/img/user_3.avif',
      ),
      Friend(
        firstName: 'Pedro',
        lastName: 'Martinez',
        email: 'pedro.m@test.com',
        phoneNumber: '+57 300 123 4404',
      ),
      Friend(
        firstName: 'Juan',
        lastName: 'Torres',
        email: 'juan.t@test.com',
        phoneNumber: '+57 300 123 45025',
        photo: 'assets/img/user_4.avif',
      ),
    ];

    for (final friend in initialFriends) {
      await db.insert('friends', friend.toMap());
    }
  }

  Future<int> createLocation(Location location) async {
    final db = await instance.database;
    return await db.insert('locations', location.toMap());
  }

  Future<List<Location>> getAllLocations() async {
    final db = await instance.database;
    final result = await db.query('locations');
    return result.map((json) => Location.fromMap(json)).toList();
  }

  Future<List<Friend>> getFriends() async {
    final db = await instance.database;
    final result = await db.query('friends');
    return result.map((json) => Friend.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Location?> assignLocationToFriend(int locationId, int friendId) async {
    final db = await instance.database;
    try {
      await db.update(
        'locations',
        {'friend_id': friendId},
        where: 'id = ?',
        whereArgs: [locationId],
      );
      final List<Map<String, dynamic>> maps = await db.query(
        'locations',
        where: 'id = ?',
        whereArgs: [locationId],
      );

      if (maps.isNotEmpty) {
        return Location.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Location>> getLocationsForFriend(int friendId) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'friend_id = ?',
      whereArgs: [friendId],
    );

    return maps.map((locationMap) => Location.fromMap(locationMap)).toList();
  }

  Future<Friend?> getFriendById(int friendId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'friends',
      where: 'id = ?',
      whereArgs: [friendId],
    );

    if (maps.isNotEmpty) {
      return Friend.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
