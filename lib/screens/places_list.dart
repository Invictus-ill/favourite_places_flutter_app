import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:favourite_places_flutter_app/providers/places_notifier.dart';
import 'package:favourite_places_flutter_app/screens/add_place.dart';
import 'package:favourite_places_flutter_app/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(context, ref) {
    //Question: Does this have to be in the build method or would a rebuild be triggered even if it is outside the build method ?
    final List<Place> placesList = ref.watch<List<Place>>(placesProvider);

    Widget content = Center(
      child: Text(
        'Add places to see them here !',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
      ),
    );

    if (placesList.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(placesList[index].image!),
              ),
              title: Text(
                placesList[index].title,
                style: Theme.of(ctx).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                placesList[index].location.address,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetails(place: placesList[index]),
                ),
              ),
            ),
          );
        },
        itemCount: placesList.length,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => AddPlaceScreen()),
              );
            },
          ),
        ],
      ),
      body: content,
    );
  }
}
