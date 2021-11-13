import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/models/package.dart';
import 'package:propertychowk/ui/views/auth/auth_controller.dart';
import 'package:propertychowk/ui/views/auth/login_view.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/utils/styles.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (controller){
          return Form(
            key: controller.signUpFormKey,
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
                        SizedBox(height: Get.height*0.015,),
                        Flexible(child: AutoSizeText("Sign up and get started.",style: TextStyles.title1.copyWith(color: Theme.of(context).backgroundColor),textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.05,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
                    validator: (val){
                      if(val!.isEmpty){
                        return "Name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Name",
                        alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.03)
                    ),
                    onSaved: (val){
                      controller.user.name=val;
                    },
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
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
                      controller.user.email=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.03)
                    ),
                  ),
                ), SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
                    validator: (val){
                      if(val!.isEmpty){
                        return "Phone Number is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    onSaved: (val){
                      controller.user.phoneNumber=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.03)
                    ),
                  ),
                ),

                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
                    obscureText: !controller.showSignUpPassword,
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
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleSignUpShowPassword,
                        child: Icon(controller.showSignUpPassword?Icons.visibility_off:Icons.visibility,color: Colors.black,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: TextFormField(
                    validator: (val){
                      if(val!.isEmpty){
                        return "Estate Name is required";
                      }
                      return null;
                    },
                    onSaved: (val){
                      controller.user.estateName=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Estate Name",
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.03)
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: DropdownButtonFormField<String>(
                    items: Get.find<PropertiesController>().packages.map((Package category) {
                      return new DropdownMenuItem(
                          value: category.id,
                          child: Row(
                            children: <Widget>[
                              Text(category.name!),
                            ],
                          )
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      controller.user.packageId=newValue as String;
                    },
                    validator: ( val){
                      if(val==null){
                        return "Package is required";
                      }
                      return null;
                    },
                    hint: AutoSizeText("Package"),
                    value: controller.user.packageId,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                        filled: true,

                        fillColor: Colors.grey[200],),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: RippleButton(
                    width: Get.width*1,
                    borderRadius: BorderRadius.circular(35),
                    onPressed: (){
                      if(controller.signUpFormKey.currentState!.validate()){
                        controller.signUpFormKey.currentState!.save();
                        controller.signUpWithEmailAndPassword();
                      }
                    },title: "Sign Up",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
                ),
                SizedBox(height: Get.height*0.02,),
                AutoSizeText.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: "Already have an account? / "
                    ),
                    TextSpan(
                        text:"Sign In",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          Get.off(()=>LoginView());
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
