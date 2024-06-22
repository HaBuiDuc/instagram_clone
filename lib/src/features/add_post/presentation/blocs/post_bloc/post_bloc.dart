import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/features/add_post/domain/use_cases/add_post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AddPost _addPost;
  PostBloc(AddPost addPost)
      : _addPost = addPost,
        super(PostInitial()) {
    on<PostEvent>((event, emit) {
    });
    on<AddingPostEvent>(_addingPost);
  }

  void _addingPost(AddingPostEvent event, Emitter emit) async {
    await _addPost(
      AddPostParams(
        caption: event.caption,
        content: event.content,
      ),
    );
  }
}
