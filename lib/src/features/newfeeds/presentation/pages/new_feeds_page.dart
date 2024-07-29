import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/widgets/post.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/profile_pages/personal_profile_page.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/profile_pages/user_profile_page.dart';
import 'package:instagram_clone/src/injection.dart';

class NewFeedsPage extends StatefulWidget {
  const NewFeedsPage({super.key});

  @override
  State<NewFeedsPage> createState() => _NewFeedsPageState();
}

class _NewFeedsPageState extends State<NewFeedsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onUserProfileNavigate(UserEntity user) {
    if (user.id == FirebaseAuth.instance.currentUser!.uid) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const PersonalProfilePage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => UserProfilePage(user: user)));
    }
  }

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
                    color: ColorPalette.dimGray
                        .withOpacity(0.3), // Set the color of the bottom border
                    width: 0.8, // Set the width of the bottom border
                  ),
                ),
              ),
            ),
          ),
          shadowColor: ColorPalette.dimGray,
        ),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoaded) {
              var posts = state.posts;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Post(
                          postEntity: posts[index],
                          onUserProfileNavigate: _onUserProfileNavigate,
                        );
                      },
                    ),
                  )
                ],
              );
            }
            
            if (state is PostsLoadedFailure) {
              return const Center(child: Text('Something gone wrong!'));
            }

            return const LoadingPage();
          },
        ),
      ),
    );
  }
}
