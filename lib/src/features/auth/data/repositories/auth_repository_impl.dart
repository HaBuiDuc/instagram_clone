import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';
import 'package:instagram_clone/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:instagram_clone/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, UserCredential>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final res =
          await authRemoteDataSource.loginWithEmailPassword(email, password);
      return right(res);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailPassword(
      String email, String password, String fullName, String username) async {
    try {
      final res = await authRemoteDataSource.signUpWithEmailPassword(
        email,
        password,
        fullName,
        username,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
