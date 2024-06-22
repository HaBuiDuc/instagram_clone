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
    required super.posts,
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
      posts: map['posts'] as int,
    );
  }
}
