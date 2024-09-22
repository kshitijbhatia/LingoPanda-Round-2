import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:lingopanda_ecom_app/features/products/presentation/controllers/product_provider.dart';
import 'package:lingopanda_ecom_app/features/products/presentation/screens/product_page.dart';
import 'package:lingopanda_ecom_app/firebase_options.dart';
import 'package:lingopanda_ecom_app/network/remote_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();
SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  sharedPreferences = await SharedPreferences.getInstance();

  await FirebaseRemoteConfigService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(create: (context) => AuthController(),),
        ChangeNotifierProvider<ProductController>(create: (context) => ProductController())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final bool isLoggedIn = sharedPreferences!.containsKey(Constants.USER_LOGGED_IN);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>  MaterialApp(
        title: 'LingoPandaRound2',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          '/login' : (context) => const LoginScreen(),
          '/register' : (context) => const RegisterScreen(),
          '/home': (context) => const ProductPage()
        },
        home: isLoggedIn ? const ProductPage() : const LoginScreen(),
      ),
    );
  }
}