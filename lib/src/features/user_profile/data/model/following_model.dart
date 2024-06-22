import 'package:instagram_clone/src/features/user_profile/domain/entities/following_entity.dart';

class FollowingModel extends FollowingEntity {
  FollowingModel({
    required super.follower,
    required super.followed,
  });

  Map<String, dynamic> toJson() {
    return {'follower': follower, 'followed': followed};
  }

  factory FollowingModel.fromJson(Map<String, dynamic> data) {
    return FollowingModel(
      follower: data['follower'] as String,
      followed: data['followed'] as String,
    );
  }
}
