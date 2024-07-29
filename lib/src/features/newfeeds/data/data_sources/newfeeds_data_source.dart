import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/core/common/data/firebase_data_source.dart';
import 'package:instagram_clone/src/core/common/models/post_model.dart';
import 'package:instagram_clone/src/core/common/models/user_model.dart';

abstract interface class NewfeedsDataSource {
  Future<List<PostModel>?> getPost();
  Future<UserModel?> getUser(String userId);
}

class NewfeedsDataSourceImpl implements NewfeedsDataSource {
  final FirebaseDataSource _firebaseDataSource;

  NewfeedsDataSourceImpl({required FirebaseDataSource firebaseDataSource}) : _firebaseDataSource = firebaseDataSource;

  @override
  Future<List<PostModel>?> getPost() async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('posts');
      final querySnapshot = await collectionRef.get();
      final data = querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()))
          .toList();
      return data;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    return await _firebaseDataSource.getUser(userId);
  }
}
