import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/core/errors/server_exception.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> loginWithEmailPassword(String email, String password);
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password, String fullName, String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    try {
      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return res;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password, String fullName, String username) async {
    try {
      final res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (res.user != null) {
        final db = FirebaseFirestore.instance;
        Map<String, dynamic> userData = {
          'id': res.user!.uid,
          'fullName': fullName,
          'userName': username,
          'email': email,
          'followers': 0,
          'following': 0,
          'posts': 0,
        };
        db.collection('users').add(userData).catchError((error) {
          throw ServerException(message: 'Can\'t add user data');
        });
      }
      return res;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? 'Something gone wrong!');
    }
  }
}
