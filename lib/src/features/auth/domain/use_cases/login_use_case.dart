import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/src/core/errors/failure.dart';
import 'package:instagram_clone/src/core/common/use_case/use_case.dart';
import 'package:instagram_clone/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<UserCredential, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserCredential>> call(LoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      params.email,
      params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
