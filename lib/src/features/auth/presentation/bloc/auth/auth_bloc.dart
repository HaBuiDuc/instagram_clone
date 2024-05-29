import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:instagram_clone/src/features/auth/domain/use_cases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  AuthBloc(SignUpUseCase signUpUseCase, LoginUseCase loginUseCase)
      : _signUpUseCase = signUpUseCase,
        _loginUseCase = loginUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthLoginEvent>(_onLogin);
    on<AuthInitialEvent>(
      (event, emit) => emit(
        AuthInitial(),
      ),
    );
  }

  void _onSignUp(AuthSignUpEvent event, Emitter emit) async {
    final res = await _signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        username: event.username,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(userCredential: r)),
    );
  }

  void _onLogin(AuthLoginEvent event, Emitter emit) async {
    final res = await _loginUseCase(
        LoginParams(email: event.email, password: event.password));
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(userCredential: r)),
    );
  }
}
