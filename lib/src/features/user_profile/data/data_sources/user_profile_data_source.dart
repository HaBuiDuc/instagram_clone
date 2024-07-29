import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/core/common/models/post_model.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';

abstract interface class UserProfileDataSource {
  Future<List<PostModel>> getUserPosts(String? userId);
  Future<void> addFollowing(String followed);
  Future<void> unFollow(String followed);
  Future<bool> checkFollowing(String userId);
  Future<void> updatingUserData(
    String? email,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? bio,
    int? followers,
    int? following,
    int? posts,
  );
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _currentUser = FirebaseAuth.instance.currentUser!.uid;
  @override
  Future<List<PostModel>> getUserPosts(String? userId) async {
    final id =
        (userId != null) // if no user id is given then use current user id
            ? userId
            : _currentUser;
    try {
      var collection = await _firestore
          .collection('posts')
          .where('authorId', isEqualTo: id)
          .get();

      List<PostModel> data = collection.docs
          .map((post) => PostModel.fromJson(post.data()))
          .toList();
      return data;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }

  @override
  Future<void> addFollowing(String followed) async {
    try {
      // change the following data of follower and followed
      Map<String, dynamic> data = {
        'follower': _currentUser,
        'followed': followed,
      };
      _firestore.collection('followings').add(data).then((value) {
        _firestore
            .collection('users')
            .where('id', isEqualTo: followed)
            .get()
            .then(
          (querySnapshot) {
            if (querySnapshot.size > 0) {
              querySnapshot.docs.first.reference
                  .update({'followers': FieldValue.increment(1)});
            }
          },
        );

        _firestore
            .collection('users')
            .where('id', isEqualTo: _currentUser)
            .get()
            .then(
          (querySnapshot) {
            if (querySnapshot.size > 0) {
              querySnapshot.docs.first.reference
                  .update({'following': FieldValue.increment(1)});
            }
          },
        );
      }).catchError((error) {
        throw ServerException(message: 'Can\'t add following data');
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }

  // check if log in user is following a user with the given id
  @override
  Future<bool> checkFollowing(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('followings')
          .where('followed', isEqualTo: userId)
          .where('follower', isEqualTo: _currentUser)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }

  @override
  Future<void> unFollow(String followed) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('followings')
          .where('follower', isEqualTo: _currentUser)
          .where('followed', isEqualTo: followed)
          .get();

      // delete follow data and then change the following data of follower and followed
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete().then(
          (_) {
            _firestore
                .collection('users')
                .where('id', isEqualTo: followed)
                .get()
                .then(
              (querySnapshot) {
                if (querySnapshot.size > 0) {
                  querySnapshot.docs.first.reference
                      .update({'followers': FieldValue.increment(-1)});
                }
              },
            );

            _firestore
                .collection('users')
                .where('id', isEqualTo: _currentUser)
                .get()
                .then(
              (querySnapshot) {
                if (querySnapshot.size > 0) {
                  querySnapshot.docs.first.reference
                      .update({'following': FieldValue.increment(-1)});
                }
              },
            );
          },
        );
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }

  @override
  Future<void> updatingUserData(
    String? email,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? bio,
    int? followers,
    int? following,
    int? posts,
  ) async {
    Map<String, dynamic> updates = {};
    if (email != null) updates['email'] = email;
    if (username != null) updates['userName'] = username;
    if (fullName != null) updates['fullName'] = fullName;
    if (avatarUrl != null) updates['avatarUrl'] = avatarUrl;
    if (bio != null) updates['bio'] = bio;
    if (followers != null) updates['followers'] = followers;
    if (following != null) updates['following'] = following;
    if (posts != null) updates['posts'] = posts;
    print(updates);
    try {
      await _firestore
          .collection('users')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.size > 0) {
            querySnapshot.docs.first.reference.update(updates);
          }
        },
      );
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }
}
