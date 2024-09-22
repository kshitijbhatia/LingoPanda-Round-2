import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';

class FirebaseRemoteConfigService{
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static bool get getShowDiscount => _remoteConfig.getBool(Constants.APPLY_DISCOUNT);

  static Future<void> initialize() async {
    try{
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
    }catch(error){
      log("error_initialising_remote_config : $error");
    }
  }

  static Future<void> fetchAndActivate() async {
    try{
      bool updated = await _remoteConfig.fetchAndActivate();
      if (updated) {
        log('Discount_changed');
      }
    }catch(error){
      log("error_fetching_remote_config : $error");
    }
  }
}

