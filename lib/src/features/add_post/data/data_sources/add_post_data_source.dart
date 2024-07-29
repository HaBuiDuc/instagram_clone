import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class AddPostDataSource {
  Future<void> addPost(String caption, List<String> content);
}

class AddPostDataSourceImpl implements AddPostDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<void> addPost(String caption, List<String> content) async {
    final storageRef = _firebaseStorage.ref(
      'images/${content[0].split('/').last}',
    ); // get image's name and create storage reference
    var file = File.fromUri(Uri.file(content[0]));
    storageRef.putFile(file).then((taskSnapshot) {
      return storageRef.getDownloadURL();
    }).then((downloadUrl) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      // add post data
      final newPostData = {
        'authorId': userId,
        'caption': caption,
        'content': [downloadUrl],
      };

      _postQuantityIncrement(userId);

      return _firestore.collection('posts').add(newPostData);
    }).catchError((error) {
      return error;
    });
  }

  void _postQuantityIncrement(String userId) {
    _firestore.collection('users').where('id', isEqualTo: userId).get().then(
      (querySnapshot) {
        if (querySnapshot.size > 0) {
          querySnapshot.docs.first.reference.update(
            {'followers': FieldValue.increment(1)},
          );
        }
      },
    );
  }
}
