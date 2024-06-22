import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';

abstract interface class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
}
