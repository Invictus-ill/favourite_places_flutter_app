import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  void _takePicture() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: BoxBorder.all()),
      height: 250,
      width: double.infinity,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: _takePicture,
          label: Text('Take Picture'),
          icon: Icon(Icons.camera),
        ),
      ),
    );
  }
}
