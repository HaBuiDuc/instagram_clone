import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerBottomSheet extends StatefulWidget {
  final List<File?> imageFiles;
  final void Function(int imageIndex) onSelectImage;
  const ImagePickerBottomSheet({super.key, required this.imageFiles, required this.onSelectImage});

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerBottomSheetState createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 400,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Select Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
              ),
              itemCount: widget.imageFiles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelectImage(index);
                  },
                  child: Image.file(
                    widget.imageFiles[index]!,
                    fit: BoxFit.cover,
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
