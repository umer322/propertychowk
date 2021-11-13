import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';

class RestrictedView extends StatelessWidget {
  const RestrictedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText("You can only login from one device at a time",presetFontSizes: [20,18],),
          SizedBox(height: 15,),
          TextButton(onPressed: ()async{
            await Get.find<FireBaseAuthService>().signOut();
            Get.offAllNamed("/auth");
          },child: Text("Logout"),)
        ],
      ),
    );
  }
}
