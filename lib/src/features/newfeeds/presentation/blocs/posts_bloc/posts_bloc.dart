import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/use_cases/get_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts _getPosts;
  PostsBloc(GetPosts getPosts)
      : _getPosts = getPosts,
        super(PostsInitial()) {
    on<LoadingPostsEvent>(_loadingPosts);
  }

  void _loadingPosts(LoadingPostsEvent event, Emitter emit) async {
    emit(PostsLoading());
    final res = await _getPosts(NoParams());
    res.fold(
      (l) => emit(PostsLoadedFailure(failure: l)),
      (r) => emit(
        PostsLoaded(posts: r),
      ),
    );
  }

}
