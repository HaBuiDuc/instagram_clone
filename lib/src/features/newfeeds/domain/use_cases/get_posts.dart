import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/use_case/use_case.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/post_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/posts_repository.dart';

class GetPosts implements UseCase<List<PostEntity>, NoParams> {
  final PostsRepository postRepository;

  GetPosts({required this.postRepository});
  @override
  Future<Either<Failure, List<PostEntity>>> call(NoParams params) async {
    return await postRepository.getPosts();
  }
}
