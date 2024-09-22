import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/network/network_provider.dart';

class ProductApi{
  static Future<Response> getAllProducts() async {
    try{
      final response = await dio.get(Constants.API_END_POINT);
      return response;
    } on DioException catch(error){
      log("***error_data_source : $error");
      rethrow;
    }
  }
}