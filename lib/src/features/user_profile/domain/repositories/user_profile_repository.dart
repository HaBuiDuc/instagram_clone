import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';

abstract interface class UserProfileRepository {
  Future<Either<Failure, List<PostEntity>>> getUserPosts(String? userId);
  Future<void> addFollowing(String followed);
  Future<void> unFollow(String followed);
  Future<bool> checkFollowing(String userId);
    Future<Either<Failure, void>> updatingUserData({
    String? email,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? bio,
    int? followers,
    int? following,
    int? posts,
  });
}