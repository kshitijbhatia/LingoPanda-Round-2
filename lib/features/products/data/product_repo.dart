import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';
import 'package:lingopanda_ecom_app/features/products/data/product_api.dart';
import 'package:lingopanda_ecom_app/features/products/domain/product.dart';
import 'package:lingopanda_ecom_app/network/network_error.dart';

class ProductRepo {
  static Future<List<Product>> getAllProducts() async {
    try{
      final response = await ProductApi.getAllProducts();
      List<Product> products = [];
      if(response.statusCode == 200){
        final List<dynamic> resProducts = response.data["products"];
        for(Map<String, dynamic> product in resProducts){
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }on DioException catch(error){
      CustomError customError = handleError(error);
      log("***error_repo : $error");
      throw customError;
    }
  }
}