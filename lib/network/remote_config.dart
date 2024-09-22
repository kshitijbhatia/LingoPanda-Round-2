import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';

class FirebaseRemoteConfigService{
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static bool get getShowDiscount => _remoteConfig.getBool(Constants.APPLY_DISCOUNT);

  static Future<void> _setConfigSettings() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1),
        )
    );
  }

  static Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();
    if(updated){
      log('Discount_changed');
    }
  }

  static Future<void> initialize() async {
    await _setConfigSettings();
    await fetchAndActivate();
  }
}

