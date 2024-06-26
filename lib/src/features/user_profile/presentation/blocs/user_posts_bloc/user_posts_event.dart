part of 'user_posts_bloc.dart';

sealed class UserPostsEvent extends Equatable {
  const UserPostsEvent();

  @override
  List<Object> get props => [];
}

final class LoadingUserPostsEvent extends UserPostsEvent {
  final String userId;

  const LoadingUserPostsEvent({required this.userId});
}