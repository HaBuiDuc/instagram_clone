import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/images_tab.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/profile_button.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/statistic_item.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage>
    with TickerProviderStateMixin {
  int _selectedPage = 0;
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        _selectedPage = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          var user = state.userEntity;
          context
              .read<UserPostsBloc>()
              .add(LoadingUserPostsEvent(userId: user.id));
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
                                ProfileButton(
                                  label: 'Edit profile',
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 8),
                                ProfileButton(
                                  label: 'Share profile',
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
        return const LoadingPage();
      },
    );
  }
}
