import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';

CustomError handleError(dynamic error){
  CustomError customError = const CustomError();
  customError = customError.copyWith(
    message: error.toString(),
    description: "Error Occurred. Please try again",
    errorType: "toast"
  );
  if(error is FirebaseAuthException){
    customError = customError.copyWith(
      message: error.code
    );
    switch(error.code){
      case "invalid-email":
        customError = customError.copyWith(
          errorType: "email",
          description: "Please enter a valid email"
        );
        break;
      case "invalid-credential":
      case "user-not-found":
        customError = customError.copyWith(
          description: "Wrong Email Or Password"
        );
        break;
      case "wrong-password":
        customError = customError.copyWith(
          description: "Wrong Password"
        );
        break;
      case "network-request-failed":
        customError = customError.copyWith(
            description: "Please check your internet connection"
        );
        break;
      case "too-many-requests":
        customError = customError.copyWith(
          description: "Too many requests. Please wait"
        );
        break;
      case "email-already-in-use":
        customError = customError.copyWith(
          errorType: "email",
          description: "Email Already Exists"
        );
        break;
      case "weak-password":
        customError = customError.copyWith(
          errorType: "password",
          description: error.message!
        );
        break;
      case "requires-recent-login":
        customError = customError.copyWith(
          description: "Please Login Again to Update Details"
        );
        break;
      case "user-deleted":
        customError = customError.copyWith(
            description: "Account Already Deleted"
        );
        break;
      default:
        customError = customError.copyWith(
            description: "Unknown Error. Please try again later"
        );
        break;
    }
  }else if( error is DioException ){
    customError = customError.copyWith(
      message: error.message!,
      errorType: "toast",
      description: "Please check your internet connection!"
    );
  }
  return customError;
}