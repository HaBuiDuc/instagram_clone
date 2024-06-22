import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/core/common/models/post_model.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';
import 'package:instagram_clone/src/features/newfeeds/data/models/user_model.dart';

abstract interface class FirebaseDataSource {
  Future<List<PostModel>?> getPost();
  Future<UserModel?> getUser(String userId);
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
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
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      var collection = await firestore
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();

      Map<String, dynamic> data = collection.docs.first.data();
      final UserModel userModel = UserModel.fromJson(data);

      return userModel;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }
}
