import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/user_profile/domain/repositories/user_profile_repository.dart';

class Unfollow implements UseCase<void, String> {
  final UserProfileRepository userProfileRepository;

  Unfollow({required this.userProfileRepository});
  @override
  Future<Either<Failure, void>> call(String params) async {
    final res = await userProfileRepository.unFollow(params);
    return right(res);
  }
}
