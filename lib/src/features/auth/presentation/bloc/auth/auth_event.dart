part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialEvent extends AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String username;

  const AuthSignUpEvent({required this.email, required this.password, required this.fullName, required this.username});
}
class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({required this.email, required this.password});
}
