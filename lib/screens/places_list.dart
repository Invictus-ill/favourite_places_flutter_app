import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget {
  PlacesListScreen({super.key});

  final List<Place> placesList = [
    Place(id: '1', title: 'Paris'),
    Place(id: '2', title: 'Rajisthan'),
  ];

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(
              placesList[index].title,
              style: Theme.of(
                ctx,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          );
        },
        itemCount: placesList.length,
      ),
    );
  }
}
