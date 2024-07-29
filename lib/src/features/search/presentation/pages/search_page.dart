import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/services/user_services.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/search/presentation/blocs/search_user_bloc/search_user_bloc.dart';
import 'package:instagram_clone/src/features/search/presentation/widgets/search_result_item.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/profile_pages/personal_profile_page.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/profile_pages/user_profile_page.dart';
import 'package:instagram_clone/src/injection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late SearchUserBloc _searchUserBloc;
  @override
  void initState() {
    super.initState();
    _searchUserBloc = context.read<SearchUserBloc>();
  }

  void _onUserNavigate(UserEntity user) {
    // if user id is equal to log in user id then navigate to the personal page, if not navigate to the user profile page
    if (user.id ==
        serviceLocator<UserServices>().getCurrentUserInstance().uid) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const PersonalProfilePage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => UserProfilePage(user: user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            height: 36,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchUserBloc.add(SearchingUserEvent(query: value));
                });
              },
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                fillColor: ColorPalette.cultured,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<SearchUserBloc, SearchUserState>(
            builder: (context, state) {
              if (_searchController.text.isNotEmpty) {
                if (state is UserFound) {
                  // if user founded based on the provided user id then show the list
                  if (state.userList.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.userList.length,
                        itemBuilder: (context, index) {
                          return SearchResultItem(
                            user: state.userList[index],
                            onUserNavigate: _onUserNavigate,
                          );
                        },
                      ),
                    );
                  }
                  return const Text('not found');
                }
              }
              if (state is UserSearchLoading) {
                return const LoadingPage();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
