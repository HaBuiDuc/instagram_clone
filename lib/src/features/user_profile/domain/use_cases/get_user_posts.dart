import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/post_entity.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/user_profile/domain/repositories/user_profile_repository.dart';

class GetUserPosts implements UseCase<List<PostEntity>, String> {
  final UserProfileRepository userProfileRepository;

  GetUserPosts({required this.userProfileRepository});
  @override
  Future<Either<Failure, List<PostEntity>>> call(String params) async {
    return await userProfileRepository.getUserPosts(params);
  }
}
