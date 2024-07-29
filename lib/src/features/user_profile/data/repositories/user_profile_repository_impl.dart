import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';
import 'package:instagram_clone/src/features/user_profile/data/data_sources/user_profile_data_source.dart';
import 'package:instagram_clone/src/features/user_profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSource userProfileDataSource;

  UserProfileRepositoryImpl({required this.userProfileDataSource});
  @override
  Future<Either<Failure, List<PostEntity>>> getUserPosts(String? userId) async {
    final res = await userProfileDataSource.getUserPosts(userId);
    return right(res);
  }

  @override
  Future<void> addFollowing(String followed) async {
    return await userProfileDataSource.addFollowing(followed);
  }

  @override
  Future<bool> checkFollowing(String userId) async {
    return userProfileDataSource.checkFollowing(userId);
  }

  @override
  Future<void> unFollow(String followed) async {
    return await userProfileDataSource.unFollow(followed);
  }

  @override
  Future<Either<Failure, void>> updatingUserData({
    String? email,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? bio,
    int? followers,
    int? following,
    int? posts,
  }) async {
    try {
      final res = userProfileDataSource.updatingUserData(
        email,
        username,
        fullName,
        avatarUrl,
        bio,
        followers,
        following,
        posts,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
