import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:lingopanda_ecom_app/features/authentication/data/authentication_api.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/user.dart';
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
      return user;
    }catch(error){
      CustomError authError = handleError(error);
      log("***error_repo : $error");
      throw authError;
    }
  }

  static Future<User> signup({required String name, required String email, required String password}) async {
    try{
      final UserCredential response = await AuthenticationApi.signup(name: name, email: email, password: password);

      final Map<String, dynamic> json = {
        'uid' : response.user!.uid,
        'name' : name,
        'email' : response.user!.email,
        'createdOn' : response.user!.metadata.creationTime.toString(),
      };
      log("$json");
      final User user = User.fromJson(json);
      return user;
    }catch(error){
      CustomError authError = handleError(error);
      log("***error_repo : $error");
      throw authError;
    }
  }
}