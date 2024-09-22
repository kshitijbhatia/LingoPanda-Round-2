import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/main.dart';

class AppUtils{
  static String getDiscountedPrice({required double discount, required double originalPrice}){
    double discountedPrice  = originalPrice - ((originalPrice * discount) / 100);
    String formattedValue = discountedPrice.toStringAsFixed(2);
    return formattedValue;
  }

  static void logout(){
    sharedPreferences!.remove(Constants.USER_LOGGED_IN);
    sharedPreferences!.remove(Constants.USER_EMAIL);
    sharedPreferences!.remove(Constants.USER_NAME);
    sharedPreferences!.remove(Constants.USER_ID);
  }
}