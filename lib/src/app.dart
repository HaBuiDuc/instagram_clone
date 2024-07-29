import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/theme/app_theme.dart';
import 'package:instagram_clone/src/features/add_post/presentation/pages/select_image_page.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/pages/new_feeds_page.dart';
import 'package:instagram_clone/src/features/search/presentation/pages/explore_page.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/profile_pages/personal_profile_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentPage = 0;

  void _setPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadingPostsEvent());
    // context
    //     .read<UserBloc>()
    //     .add(LoadingUserEvent(userId: FirebaseAuth.instance.currentUser!.uid));
    context.read<UserProfileBloc>().add(GetCurrentUserEvent());
  }

  Widget _bottomBarIcon(String path) {
    if (path.split('/')[0] == 'assets') {
      if (path == 'assets/images/default_avatar.png') {
        return ClipOval(
          
          child: Image.asset(
            path,
            width: 24,
            height: 24,
          ),
        );
      }
      return Image.asset(
        path,
        width: 24,
        height: 24,
      );
    }
    return ClipOval(
      child: Image.network(
        path,
        width: 24,
        height: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram clone',
      theme: AppTheme.appTheme,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _setPage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentPage,
          items: [
            BottomNavigationBarItem(
              icon: _bottomBarIcon((_currentPage == 0)
                  ? 'assets/icons/home_icon_focused.png'
                  : 'assets/icons/home_icon.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _bottomBarIcon((_currentPage == 1)
                  ? 'assets/icons/search_icon_focused.png'
                  : 'assets/icons/search_icon.png'),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _bottomBarIcon('assets/icons/new_post_icon.png'),
              label: 'New Post',
            ),
            BottomNavigationBarItem(
              icon: _bottomBarIcon((_currentPage == 3)
                  ? 'assets/icons/like_icon_focused.png'
                  : 'assets/icons/like_icon.png'),
              label: 'Liked',
            ),
            BottomNavigationBarItem(
              icon: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    if (state.userEntity.avatarUrl != null) {
                      return _bottomBarIcon(state.userEntity.avatarUrl!);
                    }
                  }
                  return _bottomBarIcon('assets/images/default_avatar.png');
                },
              ),
              label: 'User Profile',
            ),
          ],
        ),
        body: <Widget>[
          const NewFeedsPage(),
          const ExplorePage(),
          const SelectImagePage(),
          const SelectImagePage(),
          const PersonalProfilePage()
        ][_currentPage],
      ),
    );
  }
}
