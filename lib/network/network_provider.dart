import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: Constants.BASE_URL,
    headers: {
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  )
);
