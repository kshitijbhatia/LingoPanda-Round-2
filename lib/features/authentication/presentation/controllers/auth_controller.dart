import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lingopanda_ecom_app/features/authentication/data/authentication_repo.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/user.dart';
import 'package:lingopanda_ecom_app/main.dart';

class AuthController extends ChangeNotifier{
  bool loading = false;

  String? _emailError;
  String? _passError;
  String? _nameError;

  String? get emailError => _emailError;
  String? get passwordError => _passError;
  String? get nameError => _nameError;

  void setEmailError(String? error){
    _emailError = error;
    notifyListeners();
  }

  void setPasswordError(String? error){
    _passError = error;
    notifyListeners();
  }

  setNameError(String? error){
    _nameError = error;
    notifyListeners();
  }

  clearLoginForm(){
    setEmailError(null);
    setPasswordError(null);
    notifyListeners();
  }

  clearRegisterForm(){
    setNameError(null);
    setEmailError(null);
    setPasswordError(null);
    notifyListeners();
  }

  Future<void> login ({
    required String email,
    required String password
  }) async {
    try{
      loading = true;
      notifyListeners();
      final User response =  await AuthenticationRepo.login(email: email, password: password);
      navigatorKey.currentState?.pushNamed('/home');
    } on AuthError catch(error){
      if(error.errorType == "email"){
        setEmailError(error.description);
      }else if(error.errorType == "password"){
        setPasswordError(error.description);
      }else if(error.errorType == "toast"){
        Fluttertoast.showToast(msg: error.description);
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> signup ({
    required String name,
    required String email,
    required String password,
  }) async {
    try{
      loading = true;
      notifyListeners();
      final User response =  await AuthenticationRepo.signup(name: name, email: email, password: password);
      navigatorKey.currentState?.pushNamed('/home');
    }on AuthError catch(error){
      if(error.errorType == "email"){
        setEmailError(error.description);
      }else if(error.errorType == "password"){
        setPasswordError(error.description);
      }else if(error.errorType == "toast"){
        Fluttertoast.showToast(msg: error.description);
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}