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
  Color? textColor
}){
  return Text(
    text,
    style: TextStyle(
      fontFamily: "Poppins-Regular",
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: textColor ?? Colors.black
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
      obscureText: text == "Password" && !showPassword ? true : false,
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
          // suffixIcon: text == "Password"
          //     ? IconButton(
          //   onPressed: _changePasswordVisibility,
          //   icon: _showPassword
          //       ? const Icon(Icons.visibility, size: 20,)
          //       : const Icon(Icons.visibility_off, size: 20,),)
          //     : (widget.controller.text.isNotEmpty
          //     ? IconButton(
          //   onPressed: (){
          //     widget.controller.text = "";
          //     widget.removeError();
          //   },
          //   icon: const Icon(Icons.close, size: 20,),
          // ) : null
          // )
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