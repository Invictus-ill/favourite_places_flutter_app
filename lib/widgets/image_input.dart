import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});
  final void Function(File image) onSelectImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final finalImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (finalImage == null) {
      return; //Could be null if user closes the camera without taking a photo
    }

    setState(() {
      _takenImage = File(finalImage.path);
    });

    widget.onSelectImage(_takenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_takenImage != null) {
      content = GestureDetector(
        child: Image.file(
          _takenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        onTap: () => _takePicture(),
      );
    } else {
      content = ElevatedButton.icon(
        onPressed: _takePicture,
        label: Text('Take Picture'),
        icon: Icon(Icons.camera),
      );
    }

    return Container(
      decoration: BoxDecoration(border: BoxBorder.all()),
      height: 250,
      width: double.infinity,
      child: Center(child: content),
    );
  }
}
