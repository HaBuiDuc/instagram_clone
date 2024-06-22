part of 'following_bloc.dart';

sealed class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

final class FollowingInitial extends FollowingState {}

final class FollowingChecked extends FollowingState {
  final bool result;

  const FollowingChecked({required this.result});
}

final class FollowingActionDone extends FollowingState {}

final class FollowingFailure extends FollowingState {
  final Failure failure;

  const FollowingFailure({required this.failure});
}

final class FollowingLoading extends FollowingState {}
