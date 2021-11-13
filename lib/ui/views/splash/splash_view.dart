import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';
import 'dart:math' as Math;

class SplashScreen extends StatefulWidget {
  static Route route(){
    return MaterialPageRoute(builder: (_)=>SplashScreen());
  }
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  bool showFront = true;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync:this,duration: Duration(milliseconds: 2500), value: 0);
    controller.forward().
    then((value)async{
      Future.delayed(Duration(seconds: 1),()async{
//      await Get.find<FireBaseAuthService>().signOut();
        if(Get.find<FireBaseAuthService>().isLoggedIn){
          Get.offNamed("/tabs");
        }
        else{
          Get.offNamed("/auth");
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(
                    (controller.value) * Math.pi*2
                ),
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height - 130,
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Image.asset("assets/splash_logo.png"),
                ),
              );
            },
          ),
//          Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}

