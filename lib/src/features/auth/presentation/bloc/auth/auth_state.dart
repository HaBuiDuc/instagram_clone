part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserCredential userCredential;

  const AuthSuccess({required this.userCredential});
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}