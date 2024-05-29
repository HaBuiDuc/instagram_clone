import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String userId);
}