import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Center(child: Image.asset("assets/apple.png",height: Get.width*0.2,width: Get.width*0.2,))),
      Expanded(child: Center(child: Image.asset("assets/facebook.png",height: Get.width*0.2,width: Get.width*0.2,))),
      Expanded(child: Center(child: Image.asset("assets/twitter.png",height: Get.width*0.2,width: Get.width*0.2,),)),
      Expanded(child: Center(child: Image.asset("assets/google.png",height: Get.width*0.2,width: Get.width*0.2,)))
    ],);
  }
}
