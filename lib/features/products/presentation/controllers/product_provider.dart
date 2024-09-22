import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lingopanda_ecom_app/features/authentication/domain/authentication_error.dart';
import 'package:lingopanda_ecom_app/features/products/data/product_repo.dart';
import 'package:lingopanda_ecom_app/features/products/domain/product.dart';

class ProductController extends ChangeNotifier{
  List<Product> products = [];
  bool loading = false;
  bool hasError = false;

  Future<List<Product>?> getAllProducts() async {
    try{
      loading = true;
      hasError = false;
      notifyListeners();
      final response = await ProductRepo.getAllProducts();
      products = response;
      notifyListeners();
    }on CustomError catch(error){
      if(error.errorType == "toast"){
        Fluttertoast.showToast(msg: error.description);
      }
      hasError = true;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}