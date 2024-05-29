import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/post_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';

class Post extends StatefulWidget {
  final PostEntity postEntity;
  const Post({super.key, required this.postEntity});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  int _currentIndex = 0;
  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  void _loadUserInfo() {
    context
        .read<UserBloc>()
        .add(LoadingUserEvent(userId: widget.postEntity.authorId));
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          var user = state.userEntity;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: ClipOval(
                          child: user.avatarUrl != null
                              ? Image.network(user.avatarUrl!)
                              : Image.asset('assets/images/default_avatar.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          user.userName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                items: widget.postEntity.content.map((img) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                    aspectRatio: 4.5 / 5,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    enableInfiniteScroll: false),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/like_icon.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/comment_icon.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/message_icon.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: CarouselIndicator(
                        count: widget.postEntity.content.length,
                        index: _currentIndex,
                        color: Colors.grey,
                        activeColor: Colors.blue,
                        width: 6,
                        height: 6,
                      ),
                    ),
                  ),
                  const Icon(Icons.abc)
                ],
              ),
            ],
          );
        }
        return const LoadingPage();
      },
    );
  }
}
