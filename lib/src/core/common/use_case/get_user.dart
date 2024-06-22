import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/user_repository.dart';

class GetUser implements UseCase<UserEntity, String> {
  final UserRepository userRepository;

  GetUser({required this.userRepository});
  @override
  Future<Either<Failure, UserEntity>> call(String params) async {
    return await userRepository.getUser(params);
  }
}