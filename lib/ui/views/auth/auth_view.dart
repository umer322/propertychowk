import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/auth/login_view.dart';
import 'package:propertychowk/ui/views/auth/signup_view.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/utils/styles.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
        child: Column(
          children: [
            SizedBox(
              height: Get.height*0.15,
            ),
            SizedBox(
                width: Get.width*0.7,
                child: Image.asset("assets/logo.png")),
            SizedBox(
              height: Get.height*0.07,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Get.height*0.02),
              child: AutoSizeText("Welcome!",style: TextStyles.h1.copyWith(fontSize: FontSizes.s48)),
            ),
            AutoSizeText("Get started by logging into your account.",style: TextStyles.title2,),
            SizedBox(
              height: Get.height*0.07,
            ),
            RippleButton(
              width: Get.width*1,
              borderRadius: BorderRadius.circular(35),
              onPressed: (){
                Get.to(()=>SignUpView());
              },title: "Sign Up",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
            SizedBox(height: Get.height*0.02,),
            RippleButton(
              width: Get.width*1,
              borderRadius: BorderRadius.circular(35),
              onPressed: (){
                Get.to(()=>LoginView());
              },title: "Sign In",backGroundColor: Theme.of(context).backgroundColor,titleColor: Theme.of(context).primaryColorDark,fontSize: FontSizes.s18,elevation: 10,),
          ],
        ),
      ),
    );
  }
}
