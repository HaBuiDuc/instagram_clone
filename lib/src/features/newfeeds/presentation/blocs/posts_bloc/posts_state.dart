part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class PostsLoaded extends PostsState {
  final List<PostEntity> posts;

  const PostsLoaded({required this.posts});
}

final class PostsLoading extends PostsState {}

final class PostsLoadedFailure extends PostsState {
  final Failure failure;

  const PostsLoadedFailure({required this.failure});
}
