import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingopanda_ecom_app/Constants/colors.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/app_utils/common_widgets.dart';
import 'package:lingopanda_ecom_app/features/products/presentation/controllers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget{
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProductController>(context, listen: false).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: _appBar(),
      ),
    );
  }


  _appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.blueColor,
      foregroundColor: Colors.white,
      title: Container(
        child: Row(
          children: [
            commonText(
              text: Constants.APP_NAME,
              textColor: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600
            )
          ],
        ),
      ),
    );
  }

}