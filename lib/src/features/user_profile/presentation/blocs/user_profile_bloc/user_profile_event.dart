part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

final class GetCurrentUserEvent extends UserProfileEvent {
}

final class UpdatingUserEvent extends UserProfileEvent {
  final String? email;
  final String? username;
  final String? fullName;
  final String? avatarUrl;
  final String? bio;
  final int? followers;
  final int? following;
  final int? posts;

  const UpdatingUserEvent({
    this.email,
    this.username,
    this.fullName,
    this.avatarUrl,
    this.bio,
    this.followers,
    this.following,
    this.posts,
  });
}
