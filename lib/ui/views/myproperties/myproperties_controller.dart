
import 'dart:async';

import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/models/property.dart';

class MyPropertiesController extends GetxController{
  List<Property> myProperties=[];
  late StreamSubscription propertiesListener;
  getMyProperties(){
    myProperties=Get.find<PropertiesController>().properties.where((e) => e.sellerId==Get.find<UserController>().currentUser.value.id).toList();
    propertiesListener=Get.find<PropertiesController>().properties.listen((data) {
      myProperties=data.where((e) =>  e.sellerId==Get.find<UserController>().currentUser.value.id).toList();
      update();
    });
    update();
  }

  @override
  void onClose() {
    propertiesListener.cancel();
    super.onClose();
  }
  @override
  void onInit() {
    getMyProperties();
    super.onInit();
  }
}