import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';
import 'package:lingopanda_ecom_app/features/products/data/product_repo.dart';
import 'package:lingopanda_ecom_app/features/products/domain/product.dart';

class ProductController extends ChangeNotifier{
  List<Product>? products;

  Future<void> getAllProducts() async {
    try{
      final response = await ProductRepo.getAllProducts();
      products = response;
      notifyListeners();
    }on CustomError catch(error){
      if(error.errorType == "toast"){
        Fluttertoast.showToast(msg: error.description);
      }
    }
  }
}