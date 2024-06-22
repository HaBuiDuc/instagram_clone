import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/features/add_post/domain/repositories/post_repository.dart';

class AddPost implements UseCase<void, AddPostParams> {
  final PostRepository postRepository;

  AddPost({required this.postRepository});
  @override
  Future<Either<Failure, void>> call(AddPostParams params) async {
    await postRepository.addPost(
      params.caption,
      params.content,
    );
    return right(null);
  }
}

class AddPostParams {
  final String caption;
  final List<String> content;

  AddPostParams({
    required this.caption,
    required this.content,
  });
}
