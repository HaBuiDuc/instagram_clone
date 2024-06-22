part of 'search_user_bloc.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

final class SearchUserInitial extends SearchUserState {}

final class UserFound extends SearchUserState {
  final List<UserEntity> userList;

  const UserFound({required this.userList});
}

final class UserSearchLoading extends SearchUserState {}

final class UserSearchFailure extends SearchUserState {
  final Failure failure;

  const UserSearchFailure({required this.failure});
}
