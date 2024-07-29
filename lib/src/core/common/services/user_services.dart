import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/common/data/firebase_data_source.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';

abstract interface class UserServices {
  User getCurrentUserInstance();
  Future<Either<Failure, UserEntity>> getUser(String userId);
  Future<Either<Failure, UserEntity>> getCurrentUser();
}

class UserServicesImpl implements UserServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDataSource firebaseDataSource;

  // get firebase user instance, not user profile data store in firestore.
  @override
  User getCurrentUserInstance() {
    return _firebaseAuth.currentUser!;
  }

  UserServicesImpl({required this.firebaseDataSource});
  @override
  Future<Either<Failure, UserEntity>> getUser(String userId) async {
    final res = await firebaseDataSource.getUser(userId);
    if (res != null) {
      return right(res);
    }
    return left(Failure(message: 'Can\'t get user data'));
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    final res = await firebaseDataSource.getCurrentUser();
    if (res != null) {
      return right(res);
    }
    return left(Failure(message: 'Can\'t get user data'));
  }
}
