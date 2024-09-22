import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/features/authentication/data/authentication_api.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/user.dart';
import 'package:lingopanda_ecom_app/main.dart';
import 'package:lingopanda_ecom_app/network/network_error.dart';

class AuthenticationRepo {

  static Future<User> login({required String email, required String password}) async {
    try{
      final UserCredential response = await AuthenticationApi.login(email: email, password: password);

      final Map<String, dynamic> json = {
        'uid' : response.user!.uid,
        'name' : response.user!.displayName,
        'email' : response.user!.email,
        'createdOn' : response.user!.metadata.creationTime.toString(),
      };

      final User user = User.fromJson(json);

      sharedPreferences!.setBool(Constants.USER_LOGGED_IN, true);
      sharedPreferences!.setString(Constants.USER_ID, user.uid);
      sharedPreferences!.setString(Constants.USER_NAME, user.name);
      sharedPreferences!.setString(Constants.USER_EMAIL, user.email);

      return user;
    }catch(error){
      CustomError authError = handleError(error);
      log("***error_repo : $error");
      throw authError;
    }
  }

  static Future<User> signup({required String name, required String email, required String password}) async {
    try{
      final UserCredential response = await AuthenticationApi.signup(name: name.trim(), email: email.trim(), password: password.trim());

      final Map<String, dynamic> json = {
        'name' : name,
        'email' : response.user!.email,
        'createdOn' : response.user!.metadata.creationTime.toString(),
      };

      final CollectionReference users = FirebaseFirestore.instance.collection('user');
      await users.doc(response.user!.uid).set(json);

      json['uid'] = response.user!.uid;
      final User user = User.fromJson(json);

      sharedPreferences!.setBool(Constants.USER_LOGGED_IN, true);
      sharedPreferences!.setString(Constants.USER_ID, user.uid);
      sharedPreferences!.setString(Constants.USER_NAME, user.name);
      sharedPreferences!.setString(Constants.USER_EMAIL, user.email);

      return user;
    }catch(error){
      CustomError authError = handleError(error);
      log("***error_repo : $error");
      throw authError;
    }
  }
}