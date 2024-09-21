import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier{

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
}