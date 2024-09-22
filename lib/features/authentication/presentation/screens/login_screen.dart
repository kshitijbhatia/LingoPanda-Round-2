import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingopanda_ecom_app/Constants/colors.dart';
import 'package:lingopanda_ecom_app/Constants/constants.dart';
import 'package:lingopanda_ecom_app/app_utils/common_widgets.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:lingopanda_ecom_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  _navigateToRegisterPage(){
    HapticFeedback.lightImpact();
    loginFormKey.currentState!.reset();
    emailController.clear();
    passwordController.clear();
    Provider.of<AuthController>(context, listen: false).clearLoginForm();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
  }

  @override
  Widget build(BuildContext context) {

    final bool isLoading = context.watch<AuthController>().loading;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _header(),
                isLoading == false ? _loginForm() : _loginInProgress(),
                isLoading == false ? _loginSubmit() : 0.pw
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _header() {
    return Container(
      width: double.infinity,
      height: 40.h,
      color: AppColors.backgroundColor,
      padding: EdgeInsets.only(left: 15.w,),
      margin: EdgeInsets.only(top: 20.h),
      alignment: Alignment.centerLeft,
      child: commonText(
        text: Constants.APP_NAME,
        fontSize: 26.sp,
        fontWeight: FontWeight.w600,
        textColor: AppColors.blueColor
      )
    );
  }

  Widget _loginForm() {
    return Consumer<AuthController>(
      builder: (context, provider, child) =>  Form(
        key: loginFormKey,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextInput(
                text: 'Email',
                controller: emailController,
                error: provider.emailError,
                removeError: () => provider.setEmailError(null),
                focusNode: _emailFocusNode,
                showPassword: false
              ),
              20.ph,
              TextInput(
                text: 'Password',
                controller: passwordController,
                error: provider.passwordError ,
                removeError: () => provider.setPasswordError(null),
                focusNode: _passwordFocusNode,
                showPassword: false
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginSubmit() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 25.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<AuthController>(
            builder: (context, provider, child) =>  commonButton(
              width: double.infinity,
              height: 50.h,
              text: 'Login',
              formKey: loginFormKey,
              onPressed: () async {
                if(provider.loading == false){
                  await provider.login(email: emailController.text, password: passwordController.text);
                }
              },
            ),
          ),
          10.ph,
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "New here? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                    text: "Signup",
                    style: const TextStyle(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _navigateToRegisterPage
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginInProgress(){
    return Container(
      color: AppColors.backgroundColor,
      alignment: Alignment.center,
      child: Container(
        width: 35.w,
        height: 30.h,
        child: const CircularProgressIndicator(color: AppColors.blueColor,),
      ),
    );
  }

}