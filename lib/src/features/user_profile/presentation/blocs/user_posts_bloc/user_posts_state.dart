part of 'user_posts_bloc.dart';

sealed class UserPostsState extends Equatable {
  const UserPostsState();
  
  @override
  List<Object> get props => [];
}

final class UserPostsInitial extends UserPostsState {}

final class UserPostsLoading extends UserPostsState {}

final class UserPostsLoaded extends UserPostsState {
  final List<PostEntity> userPosts;

  const UserPostsLoaded({required this.userPosts});
}

final class UserPostLoadedFailure extends UserPostsState {
  final Failure failure;

  const UserPostLoadedFailure({required this.failure});
}