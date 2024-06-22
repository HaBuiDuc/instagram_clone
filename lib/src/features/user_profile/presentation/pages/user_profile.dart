import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/following_bloc/following_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/images_tab.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/profile_button.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/statistic_item.dart';
import 'package:instagram_clone/src/injection.dart';

class UserProfilePage extends StatefulWidget {
  final UserEntity user;
  const UserProfilePage({super.key, required this.user});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  int _selectedPage = 0;
  late final TabController tabController;
  final FollowingBloc _followingBloc =
      FollowingBloc(serviceLocator(), serviceLocator(), serviceLocator());
  final UserPostsBloc _userPostsBloc = UserPostsBloc(serviceLocator());
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        _selectedPage = tabController.index;
      });
    });
    _followingBloc.add(CheckingFollowEvent(followed: widget.user.id));
  }

  void _onFollow() {
    _followingBloc.add(AddingFollowEvent(followed: widget.user.id));
  }

  void _onUnfollow() {
    _followingBloc.add(UnfollowEvent(followed: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    _userPostsBloc.add(LoadingUserPostsEvent(userId: user.id));
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ColorPalette.black,
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock,
                size: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  user.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined)
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: (user.avatarUrl == null)
                                ? Image.asset(
                                    'assets/images/default_avatar.png',
                                    width: 96,
                                    height: 96,
                                  )
                                : Image.network(
                                    user.avatarUrl!,
                                    width: 96,
                                    height: 96,
                                  ),
                          ),
                          StatisticItem(
                            label: 'Posts',
                            value: user.posts.toString(),
                          ),
                          StatisticItem(
                            label: 'Followers',
                            value: user.followers.toString(),
                          ),
                          StatisticItem(
                            label: 'Following',
                            value: user.following.toString(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            user.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          BlocConsumer<FollowingBloc, FollowingState>(
                            listener: (context, state) {
                              if (state is FollowingActionDone) {
                                _followingBloc.add(
                                  CheckingFollowEvent(followed: user.id),
                                );
                              }
                            },
                            bloc: _followingBloc,
                            builder: (context, state) {
                              if (state is FollowingChecked && state.result) {
                                return ProfileButton(
                                  label: 'Following',
                                  onPressed: _onUnfollow,
                                );
                              }
                              return ProfileButton(
                                label: 'Follow',
                                onPressed: _onFollow,
                                backgroundColor: ColorPalette.black,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          ProfileButton(
                            label: 'Message',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: ColorPalette.black,
                      indicatorWeight: 0.5,
                      tabs: [
                        Tab(
                          icon: Image.asset(
                            'assets/icons/grid_icon.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Tab(
                          icon: Image.asset(
                            'assets/icons/tag_icon.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          <Widget>[
            BlocBuilder<UserPostsBloc, UserPostsState>(
              bloc: _userPostsBloc,
              builder: (context, state) {
                if (state is UserPostsLoaded) {
                  return ImagesTab(imageList: state.userPosts);
                }
                return const SliverToBoxAdapter(child: LoadingPage());
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(color: Colors.amber),
                height: 200,
              ),
            ),
          ][_selectedPage]
        ],
      ),
    );
  }
}
