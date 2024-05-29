import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/post_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/widgets/post.dart';
import 'package:instagram_clone/src/injection.dart';

class NewFeeds extends StatefulWidget {
  const NewFeeds({super.key});

  @override
  State<NewFeeds> createState() => _NewFeedsState();
}

class _NewFeedsState extends State<NewFeeds> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<UserBloc>(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/images/insta_logo.png',
              width: 123,
              height: 33,
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/camera_icon.png',
                width: 29,
                height: 26,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/tv_icon.png',
                      width: 29,
                      height: 26,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/message_icon.png',
                      width: 24,
                      height: 22,
                    ),
                  ),
                ],
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(
                0.8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorPalette.dimGray.withOpacity(
                          0.3), // Set the color of the bottom border
                      width: 0.8, // Set the width of the bottom border
                    ),
                  ),
                ),
              ),
            ),
            shadowColor: ColorPalette.dimGray,
          ),
          body: Column(
            children: [
              post,
            ],
          )),
    );
  }
}

var post = Post(
  postEntity: PostEntity(
    authorId: '6Ev0Bo0AgpSVGzqj4pyTAvIjfOL2',
    caption: '',
    content: [
      'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
      'https://th.bing.com/th/id/OIG3.5u5ZBGkvLQn1ELp4UqXH'
    ],
  ),
);
