import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/add_post/presentation/blocs/post_bloc/post_bloc.dart';

class AddPostPage extends StatefulWidget {
  final List<File?> imageFiles;
  const AddPostPage({super.key, required this.imageFiles});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _onAddingPost() {
    final List<String> imagePaths =
        widget.imageFiles.map((imageFile) => imageFile!.path).toList();
    context.read<PostBloc>().add(
          AddingPostEvent(
            caption: captionController.text,
            content: imagePaths,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.file(
                widget.imageFiles[0]!,
                width: 240,
                height: 240,
                fit: BoxFit.fill,
              ),
              TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onAddingPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
