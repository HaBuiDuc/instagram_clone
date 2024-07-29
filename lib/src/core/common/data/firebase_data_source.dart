import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';
import 'package:instagram_clone/src/core/common/models/user_model.dart';

abstract interface class FirebaseDataSource {
  Future<UserModel?> getUser(String userId);
  Future<UserModel?> getCurrentUser();
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel?> getUser(String userId) async {
    try {
      var collection = await _firestore
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();
      if (collection.docs.isEmpty) {
        return null;
      }
      Map<String, dynamic> data = collection.docs.first.data();
      final UserModel userModel = UserModel.fromJson(data);

      return userModel;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      var collection = await _firestore
          .collection('users')
          .where('id', isEqualTo: _currentUserId)
          .get();
      if (collection.docs.isEmpty) {
        return null;
      }
      Map<String, dynamic> data = collection.docs.first.data();
      final UserModel userModel = UserModel.fromJson(data);

      return userModel;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }
}
