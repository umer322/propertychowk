
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/widgets/appprogress_indicatior.dart';

class Show{
  static void showSnackBar(String title,String message,{int? duration}){
    Get.snackbar(title, message,snackPosition: SnackPosition.BOTTOM,duration: Duration(seconds: duration??2),colorText: Colors.black);
  }
  static void showErrorSnackBar(String title,String error,{int? duration}){
     Get.showSnackbar(GetBar(
      title: title,
       message: error,
       backgroundColor: Colors.red,
       isDismissible: true,
       duration: Duration(seconds:duration??2),
    ));
  }
  static void showLoader(){
    Get.dialog(
        Center(child: AppProgressIndication(),),barrierDismissible: false);
  }
}