import 'package:instagram_clone/src/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.userName,
    required super.fullName,
    required super.avatarUrl,
    required super.followers,
    required super.following,
    required super.posts, required super.bio,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'userName': userName,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      fullName: map['fullName'] as String,
      followers: map['followers'] as int,
      following: map['following'] as int,
      avatarUrl: map['avatarUrl'] as String?,
      bio: map['bio'] as String?,
      posts: map['posts'] as int,
    );
  }

  UserModel copyWith(
    String? email,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? bio,
    int? followers,
    int? following,
    int? posts,
  ) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      userName: username ?? userName,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
    );
  }
}
