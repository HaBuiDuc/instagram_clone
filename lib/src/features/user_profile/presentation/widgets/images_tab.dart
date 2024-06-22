import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';

class ImagesTab extends StatelessWidget {
  final List<PostEntity> imageList;
  const ImagesTab({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () {},
            child: CachedNetworkImage(
              imageUrl: imageList[index].content[0],
              fit: BoxFit.cover,
            ),
          );
        },
        childCount: imageList.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
    );
  }
}
