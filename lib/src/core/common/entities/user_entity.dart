class UserEntity {
  final String id;
  final String email;
  final String userName;
  final String fullName;
  final int followers;
  final int following;
  final int posts;
  final String? avatarUrl;

  UserEntity({
    required this.id,
    required this.email,
    required this.userName,
    required this.fullName,
    required this.avatarUrl,
    required this.followers,
    required this.following,
    required this.posts,
  });
}
