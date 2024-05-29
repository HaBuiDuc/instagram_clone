import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/post_entity.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsEvent>((event, emit) {});
    on<LoadingPostsEvent>(_loadingPosts);
  }

  void _loadingPosts(LoadingPostsEvent event, Emitter emit) {}
}
