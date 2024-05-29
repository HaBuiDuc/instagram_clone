import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/add_post/presentation/widgets/image_picker_bottom_sheet.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  List<File?> imageFiles = [];
  int selectedImage = 0;
  void _getImage() async {
    var images = await getAllImagesFromGallery();
    for (int i = 0; i < images.length; i++) {
      var image = await images[i].file;
      setState(() {
        imageFiles.add(image);
      });
    }
  }

  void _onSelectImage(int imageIndex) {
    setState(() {
      selectedImage = imageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          'New post',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Next',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: ColorPalette.blueSky,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (imageFiles.isNotEmpty)
            Image.file(
              imageFiles[selectedImage]!,
              fit: BoxFit.cover,
              height: 400,
            ),
          ImagePickerBottomSheet(
            imageFiles: imageFiles,
            onSelectImage: _onSelectImage,
          ),
        ],
      ),
    );
  }
}

Future<List<AssetEntity>> getAllImagesFromGallery() async {
  final PermissionState permission =
      await PhotoManager.requestPermissionExtend();
  if (permission.isAuth) {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final allAssets = await albums.first.getAssetListRange(
      start: 0,
      end: (await albums.first.assetCountAsync),
    );
    return allAssets;
  } else {
    return [];
  }
}
