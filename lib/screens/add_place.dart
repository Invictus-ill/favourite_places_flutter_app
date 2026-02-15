import 'dart:io';

import 'package:favourite_places_flutter_app/models/place.dart';
import 'package:favourite_places_flutter_app/providers/places_notifier.dart';
import 'package:favourite_places_flutter_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  late TextEditingController _titleFieldController;
  File? _selectedImage;

  void onSelectImage(File image) {
    _selectedImage = image;
  }

  @override
  initState() {
    _titleFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new place',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8.0,
          children: [
            TextField(
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.white),
              controller: _titleFieldController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            ImageInput(onSelectImage: onSelectImage),
            TextButton.icon(
              onPressed: () {
                ref
                    .read(placesProvider.notifier)
                    .addPlace(
                      Place(
                        id: DateTime.now().toString(),
                        title: _titleFieldController.text,
                        image: _selectedImage,
                      ),
                    );
                Navigator.pop(context);
              },
              label: Text('Add Place'),
              icon: Icon(Icons.add),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
