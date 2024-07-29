import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/services/user_services.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';

class GetUser implements UseCase<UserEntity, String> {
  final UserServices userServices;

  GetUser({required this.userServices});
  @override
  Future<Either<Failure, UserEntity>> call(String params) async {
    return await userServices.getUser(params);
  }
}
