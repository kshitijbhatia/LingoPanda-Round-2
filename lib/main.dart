import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:lingopanda_ecom_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(create: (context) => AuthController(),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>  const MaterialApp(
        title: 'LingoPandaRound2',
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}