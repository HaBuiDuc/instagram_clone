import 'package:fpdart/src/either.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/post_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }
}
