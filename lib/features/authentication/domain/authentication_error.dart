import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_error.freezed.dart';

@freezed
class AuthError with _$AuthError{
  const factory AuthError({
    @Default(0) int statusCode,
    @Default("Unknown Error") String message,
    @Default("") String description,
    @Default("") String errorType,
  }) = _AuthError;
}