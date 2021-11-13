

import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';
import 'package:propertychowk/core/services/firebasedatabase_service.dart';
import 'package:propertychowk/core/services/firebasestorage_service.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/core/services/localstorage_service.dart';
import 'package:propertychowk/core/services/multimedia_service.dart';

import 'core/controllers/chat_controller.dart';

class ServicesBinder extends Bindings{
  @override
  void dependencies() {
      Get.lazyPut(() => FireBaseAuthService());
      Get.lazyPut(() => FireStoreService());
      Get.lazyPut(() => FireBaseDatabaseService());
      Get.lazyPut(() => FireBaseStorageService());
      Get.lazyPut(() => MultiMediaService());
      Get.put(LocalStorageService());
      Get.put(UserController());
      Get.put(PropertiesController());
      Get.put(ChatController());
  }
}