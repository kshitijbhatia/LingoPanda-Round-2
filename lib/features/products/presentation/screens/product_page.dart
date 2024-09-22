import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingopanda_ecom_app/Constants/colors.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/app_utils/app_utils.dart';
import 'package:lingopanda_ecom_app/app_utils/common_widgets.dart';
import 'package:lingopanda_ecom_app/features/products/domain/product.dart';
import 'package:lingopanda_ecom_app/features/products/presentation/controllers/product_provider.dart';
import 'package:lingopanda_ecom_app/main.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget{
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  bool showDiscount = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: _appBar(),
        body: FutureBuilder(
          future: Provider.of<ProductController>(context).getAllProducts(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final products = snapshot.data;
              return _bodyView(products: products!);
            }else if(snapshot.hasError){
              return Container(
                alignment: Alignment.center,
                child: commonText(text: "Error Occurred!!"),
              );
            }else{
              return Container(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonText(
              text: Constants.APP_NAME,
              textColor: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600
            ),
            GestureDetector(
              onTap: (){
                AppUtils.logout();
                navigatorKey.currentState!.pushNamed('/login');
              },
              child: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyView({required List<Product> products}){
    return Container(
      color: AppColors.backgroundColor,
        child: ListView.builder(
          itemCount: (products.length + 1) ~/ 2,
          itemBuilder: (context, index) {
            final product1 = products[index * 2];
            final product2 = (index * 2 + 1 < products.length) ? products[index * 2 + 1] : null;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _productCard(product: product1)),
                if (product2 != null) Expanded(child: _productCard(product: product2)),
              ],
            );
          },
        ),
    );
  }

  Widget _productCard({required Product product}){

    String discountedPrice = AppUtils.getDiscountedPrice(discount: product.discountPercentage, originalPrice: product.price);

    return Container(
      height: 260.h,
      margin: EdgeInsets.only(bottom: 5.h, left: 8.w, right: 8.w, top: 20.h),
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r)
      ),
      child: Column(
        children: [
          _productImage(image: product.images[0]),
          15.ph,
          Align(
            alignment: Alignment.topLeft,
            child: commonText(text: product.title, fontWeight: FontWeight.w600, textColor: Colors.black, fontSize: 12.sp),
          ),
          10.ph,
          commonText(text: product.description, fontWeight: FontWeight.w400, textColor: Colors.black, fontSize: 12.sp, maxLines: 2, overflow: TextOverflow.ellipsis),
          10.ph,
          Row(
            children: [
              commonText(text: "\$${product.price}", fontSize: 10.sp, textDecoration: showDiscount ? TextDecoration.lineThrough : null, textColor: showDiscount ? AppColors.greyColor : null),
              5.pw,
              showDiscount ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText(text: "\$$discountedPrice", fontSize: 10.sp),
                  4.pw,
                  commonText(text: "${product.discountPercentage}% off", textColor: Colors.green, fontSize: 10.sp)
                ],
              ) : 0.pw
            ],
          )
        ],
      ),
    );
  }

  Widget _productImage({required String image}){
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
            height: 125.h,
            margin: EdgeInsets.only(top : 5.h, left: 8.w, right: 8.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill
                )
            )
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
          height: 125.h,
          margin: EdgeInsets.only(top : 5.h, left: 8.w, right: 8.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey
          ),
          child: Center(
            child: SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(color: AppColors.blueColor, strokeWidth: 3,),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          margin: EdgeInsets.only(top : 5.h, left: 8.w, right: 8.w),
          alignment: Alignment.center,
          height: 125.h,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Icon(Icons.error),
        );
      },
    );
  }
}