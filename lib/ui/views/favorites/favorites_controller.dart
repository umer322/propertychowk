
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/models/property.dart';

class FavoritesController extends GetxController{
  List<Property> favoriteProperties=[];

  getFavoriteProperties(){
    Get.find<UserController>().currentUser.value.favorites!.forEach((element) {
      Property? property=Get.find<PropertiesController>().properties.firstWhere((e) => e.id==element);
      favoriteProperties.add(property);
    });
  }

  @override
  void onInit() {
    getFavoriteProperties();
    super.onInit();
  }
}