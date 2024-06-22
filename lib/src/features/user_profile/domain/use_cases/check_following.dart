import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/user_profile/data/data_sources/user_profile_data_source.dart';

class CheckFollowing implements UseCase<bool, String> {
  final UserProfileDataSource _userProfileDataSource;

  CheckFollowing({required UserProfileDataSource userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;
  @override
  Future<Either<Failure, bool>> call(String params) async {
    final res = await _userProfileDataSource.checkFollowing(params);
    return right(res);
  }
}
