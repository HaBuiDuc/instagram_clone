import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';
import 'package:instagram_clone/src/features/newfeeds/data/models/post_model.dart';
import 'package:instagram_clone/src/features/newfeeds/data/models/user_model.dart';

abstract interface class FirebaseDataSource {
  Future<List<PostModel>> getPost();
  Future<UserModel?> getUser(String userId);
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
  // FirebaseDataSourceImpl({required this.firestore});
  @override
  Future<List<PostModel>> getPost() {
    // TODO: implement getPost
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      var collection = await firestore
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();
      // DocumentSnapshot snapshot = await docRef.get();
      // Access the data
      Map<String, dynamic> data = collection.docs.first.data();
      final UserModel userModel = UserModel(
        id: data['id'],
        email: data['email'],
        userName: data['userName'],
        fullName: data['fullName'],
        avatarUrl: data['avatarUrl'],
      );
      return userModel;
    } on FirebaseException catch (e) {
      print(e);
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }
}
