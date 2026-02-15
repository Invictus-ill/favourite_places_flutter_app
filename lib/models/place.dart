import 'dart:io';

class Place {
  const Place({required this.id, required this.title, required this.image});

  final String id;
  final String title;
  final File? image;
}
