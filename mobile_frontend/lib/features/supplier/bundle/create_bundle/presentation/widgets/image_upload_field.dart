import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadField extends StatefulWidget {
  final ValueChanged<List<String>> onImagesSelected;
  const ImageUploadField({super.key, required this.onImagesSelected, required Column Function() childBuilder, required Column child, required Column customChild});

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  final List<String> _imagePaths = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imagePaths.addAll(pickedFiles.map((file) => file.path));
      });
      widget.onImagesSelected(_imagePaths);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        height: 212,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _imagePaths.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 48, color: Colors.grey[400]),
                  const Text('Click to upload images'),
                ],
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: _imagePaths.length,
                itemBuilder: (ctx, index) => Padding(
                  padding: EdgeInsets.all(4),
                  child: Image.file(File(_imagePaths[index]),
                      fit: BoxFit.cover),
                ),
              ),
      ),
    );
  }
}