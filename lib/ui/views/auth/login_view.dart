import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/auth/auth_controller.dart';
import 'package:propertychowk/ui/views/auth/signup_view.dart';
import 'package:propertychowk/ui/views/forgotpassword/forgotpassword_view.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/ui/widgets/social_logins/social_logins.dart';
import 'package:propertychowk/utils/styles.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (controller){
          return Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: Get.height*0.2,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: kToolbarHeight/2,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(onPressed: (){
                            Get.back();
                          }, icon: Icon(Icons.arrow_back)),
                        ),
                        Flexible(child: AutoSizeText("Welcome!",style: TextStyles.h1.copyWith(fontSize: FontSizes.s30,color: Theme.of(context).backgroundColor),textAlign: TextAlign.center,)),
                        SizedBox(height: Get.height*0.01,),
                        Flexible(child: AutoSizeText("Sign in and get started.",style: TextStyles.title1.copyWith(color: Theme.of(context).backgroundColor),textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.05,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (val){
                      if(val!.isEmpty){
                        return "Email is required";
                      }
                      else if(!GetUtils.isEmail(val)){
                        return "Email is invalid";
                      }
                      return null;
                    },
                    onSaved: (val){
                      controller.email=val;
                    },
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
                    obscureText: !controller.showLoginPassword,
                    validator: (val){
                      if(val!.isEmpty){
                        return "Password is required";
                      }
                      else if(val.length < 8){
                        return "Password can't be less than 8 characters";
                      }
                      return null;
                    },
                    onSaved: (val){
                      controller.password=val;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleLoginShowPassword,
                        child: Icon(controller.showLoginPassword?Icons.visibility_off:Icons.visibility,color: Colors.black,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.005,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){
                      Get.to(()=>ForgotPasswordView());
                    },child: AutoSizeText("Forgot Password!"),),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: RippleButton(
                    width: Get.width*1,
                    borderRadius: BorderRadius.circular(35),
                    onPressed: (){
                        if(controller.formKey.currentState!.validate()){
                          controller.formKey.currentState!.save();
                          controller.login();
                        }
                    },title: "Sign In",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
                ),
                SizedBox(height: Get.height*0.03,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
                  child: Row(children: [
                    Expanded(child: Container(height: 2,color: Theme.of(context).accentColor,),),
                    AutoSizeText(" OR login with ",style: TextStyles.title1.copyWith(color: Theme.of(context).accentColor),),
                    Expanded(child: Container(height: 2,color: Theme.of(context).accentColor,),),
                  ],),
                ),
                SizedBox(height: Get.height*0.03,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: SocialLogin(),
                ),
                SizedBox(height: Get.height*0.02,),
                AutoSizeText.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: "Don't have an account? / "
                    ),
                    TextSpan(
                        text:"Sign Up",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          Get.off(()=>SignUpView());
                        })
                  ],
                ),presetFontSizes: [FontSizes.s18],textAlign: TextAlign.center,),
                SizedBox(height: Get.height*0.02,),
              ],
            ),
          );
        }),
      ),
    );
  }
}
