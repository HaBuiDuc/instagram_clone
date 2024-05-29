import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/use_case/use_case.dart';
import 'package:instagram_clone/src/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserCredential, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      params.email,
      params.password,
      params.fullName,
      params.username,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String fullName;
  final String username;

  SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.username,
  });
}
