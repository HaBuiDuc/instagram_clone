import 'package:instagram_clone/src/core/common/models/post_model.dart';
import 'package:instagram_clone/src/features/add_post/data/data_sources/add_post_data_source.dart';
import 'package:instagram_clone/src/features/add_post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final AddPostDataSource firebaseDataSource;

  PostRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<void> addPost(
    String caption,
    List<String> content,
  ) async {
    return await firebaseDataSource.addPost(caption, content);
  }
}
