import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> loginWithEmailPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserCredential>> signUpWithEmailPassword(
    String email,
    String password,
    String fullName,
    String username,
  );
}
