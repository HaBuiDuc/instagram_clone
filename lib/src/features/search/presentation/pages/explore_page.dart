import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/widgets/loading_page.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/newfeeds/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:instagram_clone/src/features/search/presentation/pages/search_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  void _onSearchNavigate() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: GestureDetector(
              onTap: _onSearchNavigate,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.cultured,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorPalette.dimGray,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            centerTitle: false,
          ),
          BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsLoaded) {
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Image.network(
                      state.posts[index].content[0],
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    childCount: state.posts.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                  ),
                );
              }
              return const LoadingPage();
            },
          )
        ],
      ),
    );
  }
}
