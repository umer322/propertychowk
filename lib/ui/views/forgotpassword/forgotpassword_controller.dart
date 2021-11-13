
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';
import 'package:propertychowk/utils/show.dart';

class ForgotPasswordViewModel extends GetxController{
  late TextEditingController emailController;
  final forgotPasswordFormKey=GlobalKey<FormState>();

  sendEmail(){
    try{
      Get.find<FireBaseAuthService>().sendEmail(emailController.text);
      emailController.clear();
      Show.showSnackBar("Message", "An email has been sent to mentioned email address.Please check your email",duration: 5);
    }
    catch(e){
      Show.showErrorSnackBar("Error", "$e");
    }
  }


  @override
  void onInit() {
    emailController=TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}