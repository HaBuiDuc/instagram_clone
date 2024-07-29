import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';
import 'package:instagram_clone/src/core/common/models/user_model.dart';

abstract interface class SearchDataSource {
  Future<List<UserModel>> searchUser(String query);
}

class SearchDataSourceImpl implements SearchDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<List<UserModel>> searchUser(String query) async {
    if (query.isEmpty) {
      return List.empty();
    }
    try {
      var collection = await _firestore
          .collection('users')
          .where('userName', isGreaterThanOrEqualTo: query)
          .where('userName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      List<UserModel> data = collection.docs
          .map((post) => UserModel.fromJson(post.data()))
          .toList();
      return data;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }
}
