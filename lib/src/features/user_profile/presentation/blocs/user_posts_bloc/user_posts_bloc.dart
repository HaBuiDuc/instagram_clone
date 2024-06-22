import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/user_profile/domain/use_cases/get_user_posts.dart';

part 'user_posts_event.dart';
part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  final GetUserPosts _getUserPosts;
  UserPostsBloc(GetUserPosts getUserPosts)
      : _getUserPosts = getUserPosts,
        super(UserPostsInitial()) {
    on<LoadingUserPostsEvent>(_loadingUserPosts);
  }

  void _loadingUserPosts(LoadingUserPostsEvent event, Emitter emit) async {
    final res = await _getUserPosts(event.userId);
    res.fold(
      (l) => emit(UserPostLoadedFailure(failure: l)),
      (r) => emit(
        UserPostsLoaded(userPosts: r),
      ),
    );
  }
}
