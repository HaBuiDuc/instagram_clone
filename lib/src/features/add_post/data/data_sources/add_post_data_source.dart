import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class AddPostDataSource {
  Future<void> addPost(String caption, List<String> content);
}

class AddPostDataSourceImpl implements AddPostDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  Future<void> addPost(String caption, List<String> content) async {
    final storageRef = firebaseStorage.ref(
      'images/${content[0].split('/').last}',
    ); // get image's name and create storage reference
    var file = File.fromUri(Uri.file(content[0]));
    storageRef.putFile(file).then((taskSnapshot) {
      return storageRef.getDownloadURL();
    }).then((downloadUrl) {
      // add post data
      final newPostData = {
        'authorId': FirebaseAuth.instance.currentUser!.uid,
        'caption': caption,
        'content': [downloadUrl],
      };

      return firestore.collection('posts').add(newPostData);
    }).catchError((error) {
      return error;
    });
  }
}
