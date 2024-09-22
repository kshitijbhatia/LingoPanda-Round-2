import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationApi {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential> login({required String email, required String password}) async {
    try{
      final currentUser = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return currentUser;
    } catch(error) {
      log("***error_data_source: $error");
      rethrow;
    }
  }

  static Future<UserCredential> signup({required String name, required String email, required String password}) async {
    try {
      final UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseAuth.currentUser!.updateDisplayName(name);
      return user;
    }  catch(error) {
      log("***error_data_source: $error");
      rethrow;
    }
  }

}