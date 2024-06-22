part of 'following_bloc.dart';

sealed class FollowingEvent extends Equatable {
  const FollowingEvent();

  @override
  List<Object> get props => [];
}

final class CheckingFollowEvent extends FollowingEvent {
  final String followed;

  const CheckingFollowEvent({required this.followed});
}

final class AddingFollowEvent extends FollowingEvent {
  final String followed;

  const AddingFollowEvent({required this.followed});
}

final class UnfollowEvent extends FollowingEvent {
  final String followed;

  const UnfollowEvent({required this.followed});
}
