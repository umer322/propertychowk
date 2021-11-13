

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/models/user.dart';
import 'package:propertychowk/utils/show.dart';

class AuthController extends GetxController{
  bool showLoginPassword=false;
  bool showSignUpPassword=false;
  String? email;
  String? password;
  AppUser user=AppUser();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey=GlobalKey<FormState>();
  toggleLoginShowPassword(){
    showLoginPassword=!showLoginPassword;
    update();
  }



  toggleSignUpShowPassword(){
    showSignUpPassword=!showSignUpPassword;
    update();
  }

  signUpWithEmailAndPassword()async{
    try{
      Show.showLoader();
      user.verified=false;
      user.createdAt=DateTime.now();
      user.hotAdNumbers=0;
      user.superHotAdNumbers=0;
      await Get.find<FireBaseAuthService>().signUp(email: user.email!.trim(), password: password!);
      await Get.find<FireStoreService>().saveUser(Get.find<FireBaseAuthService>().auth.currentUser!.uid,user);
      Get.find<UserController>().justLoggedIn=true;
      Get.offAllNamed("/tabs");
    }
    catch(e){
      if(Get.isOverlaysOpen){
        Get.back();
      }
      Show.showErrorSnackBar("Error", "$e");
    }
  }

  login()async{
    try{
      Show.showLoader();
      await Get.find<FireBaseAuthService>().login(email: email!.trim(), password:password!);
      Get.find<UserController>().justLoggedIn=true;
      Get.offAllNamed("/tabs");
    }
    catch(e){
      if(Get.isOverlaysOpen){
        Get.back();
      }
      Show.showErrorSnackBar("Error", "$e");
    }
  }
}