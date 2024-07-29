import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/features/newfeeds/data/data_sources/newfeeds_data_source.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/features/newfeeds/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final NewfeedsDataSource firebaseDataSource;

  UserRepositoryImpl({required this.firebaseDataSource});
  @override
  Future<Either<Failure, UserEntity>> getUser(String userId) async {
    final res = await firebaseDataSource.getUser(userId);
    if (res != null) {
      return right(res);
    }
    return left(Failure(message: 'Can\'t get user data'));
  }
}
