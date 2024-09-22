import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';

AuthError handleError(dynamic error){
  AuthError authError = const AuthError();
  authError = authError.copyWith(
    message: error.toString(),
    description: "Error Occurred. Please try again",
    errorType: "toast"
  );
  if(error is FirebaseAuthException){
    authError = authError.copyWith(
      message: error.code
    );
    switch(error.code){
      case "invalid-email":
        authError = authError.copyWith(
          errorType: "email",
          description: "Please enter a valid email"
        );
        break;
      case "invalid-credential":
      case "user-not-found":
        authError = authError.copyWith(
          description: "Wrong Email Or Password"
        );
        break;
      case "wrong-password":
        authError = authError.copyWith(
          description: "Wrong Password"
        );
        break;
      case "network-request-failed":
        authError = authError.copyWith(
            description: "Please check your internet connection"
        );
        break;
      case "too-many-requests":
        authError = authError.copyWith(
          description: "Too many requests. Please wait"
        );
        break;
      case "email-already-in-use":
        authError = authError.copyWith(
          errorType: "email",
          description: "Email Already Exists"
        );
        break;
      case "weak-password":
        authError = authError.copyWith(
          errorType: "password",
          description: error.message!
        );
        break;
      case "requires-recent-login":
        authError = authError.copyWith(
          description: "Please Login Again to Update Details"
        );
        break;
      case "user-deleted":
        authError = authError.copyWith(
            description: "Account Already Deleted"
        );
        break;
      default:
        authError = authError.copyWith(
            description: "Unknown Error. Please try again later"
        );
        break;
    }
  }
  return authError;
}