import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/common/services/user_services.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';

class GetCurrentUser implements UseCase<UserEntity, void> {
  final UserServices userServices;

  GetCurrentUser({required this.userServices});
  @override
  Future<Either<Failure, UserEntity>> call(void params) async {
    return await userServices.getCurrentUser();
  }
}
