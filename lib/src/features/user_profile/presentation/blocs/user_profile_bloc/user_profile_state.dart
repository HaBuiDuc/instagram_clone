part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserProfileState {}

final class UserLoaded extends UserProfileState {
  final UserEntity userEntity;

  const UserLoaded({required this.userEntity});
}

final class UserLoading extends UserProfileState {}

final class UserLoadFailed extends UserProfileState {}

final class UserUpdated extends UserProfileState {}
