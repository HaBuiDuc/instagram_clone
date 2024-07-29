import 'package:fpdart/src/either.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';
import 'package:instagram_clone/src/features/add_post/data/data_sources/add_post_data_source.dart';
import 'package:instagram_clone/src/features/newfeeds/data/data_sources/newfeeds_data_source.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final NewfeedsDataSource firebaseDataSource;

  PostsRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    final res = await firebaseDataSource.getPost();
    if (res != null) {
      return right(res);
    }

    return left(Failure(message: 'Can\'t get data'));
  }
}
