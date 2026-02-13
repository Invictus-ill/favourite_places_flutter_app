import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceDetails extends ConsumerWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Center(
        child: Text(
          place.title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
