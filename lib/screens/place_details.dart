import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceDetails extends ConsumerWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final lon = place.location.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$lon&key=<key>';
  }

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              spacing: 16.0,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(locationImage),
                  radius: 64.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    place.location.address,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
