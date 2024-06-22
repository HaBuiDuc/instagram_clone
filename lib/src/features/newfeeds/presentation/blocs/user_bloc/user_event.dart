part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadingUserEvent extends UserEvent {
  final String userId;

  const LoadingUserEvent({required this.userId});
}