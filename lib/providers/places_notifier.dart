import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  //Const added to ensure incorrect update of list with add isn't done
  PlacesNotifier() : super(const []);

  void addPlace(Place place) {
    state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) =>
      PlacesNotifier(), //Question: What is ref and is it the same ref as the one in places_list
);
