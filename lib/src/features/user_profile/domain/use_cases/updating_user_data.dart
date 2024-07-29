import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/user_profile/domain/repositories/user_profile_repository.dart';

class UpdatingUserData implements UseCase<void, UpdatingUserParams> {
  final UserProfileRepository userProfileRepository;

  UpdatingUserData({required this.userProfileRepository});

  @override
  Future<Either<Failure, void>> call(UpdatingUserParams params) async {
    return await userProfileRepository.updatingUserData(
      email: params.email,
      username: params.username,
      fullName: params.fullName,
      avatarUrl: params.avatarUrl,
      bio: params.bio,
      followers: params.followers,
      following: params.following,
      posts: params.posts,
    );
  }
}

class UpdatingUserParams {
  final String? email;
  final String? username;
  final String? fullName;
  final String? avatarUrl;
  final String? bio;
  final int? followers;
  final int? following;
  final int? posts;

  UpdatingUserParams({
    required this.email,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.posts,
  });
}
