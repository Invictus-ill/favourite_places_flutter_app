import 'dart:io';

import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getPlaces() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  //Const added to ensure incorrect update of list with add isn't done
  PlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getPlaces();
    final data = await db.query('user_places');
    final dataMap = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: (row['lat'] as num).toDouble(),
              longitude: (row['lng'] as num).toDouble(),
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    state = dataMap;
  }

  Future<void> addPlace(Place place) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image!.path);
    final copiedImage = await place.image!.copy('${appDir.path}/$fileName');

    final db = await _getPlaces();
    // write primitive values, the SQL table expects TEXT for `image`
    await db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      // store the path, not the File instance
      'image': copiedImage.path,
      'lat': place.location.latitude,
      'lng': place.location.longitude,
      'address': place.location.address,
    });

    // update the in‑memory state after the row is committed
    state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) =>
      PlacesNotifier(), //Question: What is ref and is it the same ref as the one in places_list
);
