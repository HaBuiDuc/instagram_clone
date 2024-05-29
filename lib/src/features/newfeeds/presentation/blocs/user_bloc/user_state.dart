part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoaded extends UserState {
  final UserEntity userEntity;

  const UserLoaded({required this.userEntity});
}

final class UserLoading extends UserState {}

final class UserLoadedFailure extends UserState {
  final Failure failure;

  const UserLoadedFailure({required this.failure});
}
