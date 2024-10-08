import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingopanda_ecom_app/Constants/colors.dart';

Widget commonText({
  required String text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? textColor,
  int? maxLines,
  TextOverflow? overflow,
  TextDecoration? textDecoration
}){
  return Text(
    text,
    maxLines: maxLines,
    style: TextStyle(
      fontFamily: "Poppins-Regular",
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: textColor ?? Colors.black,
      overflow: overflow,
      decoration: textDecoration
    ),
  );
}

Widget commonButton({
  required String text,
  required onPressed,
  required GlobalKey<FormState> formKey,
  required double width,
  required double height,
  Color? buttonColor,
  EdgeInsetsGeometry? margin
}){
  return GestureDetector(
    onTap: (){
      if(formKey.currentState!.validate()){
        onPressed();
      }
    },
    child: Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: buttonColor ?? AppColors.blueColor
      ),
      alignment: Alignment.center,
      child: commonText(text: text, textColor: Colors.white),
    ),
  );
}

Widget TextInput({
  required String text,
  required TextEditingController controller,
  required String? error,
  required FocusNode focusNode,
  required bool showPassword,
  required removeError
}){
  return TextFormField(
      focusNode: focusNode,
      autovalidateMode: controller.text.isEmpty ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) {
        if(value == null || value.trim().isEmpty){
          if(text == "Email") return "Please enter a valid email";
          else if(text == "Password") return "Please enter a password";
          else if(text == "Name") return "Please enter a valid name";
        }
        return null;
      },
      obscureText: text == "Password" ? true : false,
      onChanged: (value) => removeError(),
      style : TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
          errorText: error,
          labelText: text,
          filled: true,
          errorMaxLines: 3,
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.only(left: 15),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
      )
  );
}


extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
    height: toDouble().h,
  );

  SizedBox get pw => SizedBox(
    width: toDouble().w,
  );
}