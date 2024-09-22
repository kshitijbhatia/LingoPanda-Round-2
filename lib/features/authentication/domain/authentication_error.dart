import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_error.freezed.dart';

@freezed
class CustomError with _$CustomError{
  const factory CustomError({
    @Default(0) int statusCode,
    @Default("Unknown Error") String message,
    @Default("") String description,
    @Default("") String errorType,
  }) = _CustomError;
}