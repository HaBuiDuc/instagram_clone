import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';

abstract interface class SearchRepository {
  Future<Either<Failure,List<UserEntity>>> searchUser(String query);
}
