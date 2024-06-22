import 'package:instagram_clone/src/core/common/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.authorId,
    required super.caption,
    required super.content,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'authorId': authorId,
      'caption': caption,
      'content': content,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      authorId: map['authorId'],
      caption: map['caption'],
      content: List<String>.from(map['content']),
    );
  }
}
