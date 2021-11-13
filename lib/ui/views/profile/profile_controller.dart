

import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firebasestorage_service.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/core/services/multimedia_service.dart';
import 'package:propertychowk/models/package.dart';
import 'package:propertychowk/models/user.dart';
import 'package:propertychowk/utils/show.dart';

class ProfileController extends GetxController{
    late AppUser user;
    Package? package;
    bool loadingImage=false;
    bool edit=false;
    String? imageUrl;

    toggleEdit(){
      edit=!edit;
      update();
    }

    setImage()async{
      final multiMediaService=Get.find<MultiMediaService>();
      SelectImage? type=await multiMediaService.selectImageFrom();
      if(type!=null){
        String? image=await multiMediaService.pickImage(type);
        if(image!=null){
          String? croppedImage=await multiMediaService.cropImage(image);
         if(croppedImage!=null){
           imageUrl=croppedImage;
         }
         else{
           imageUrl=image;
         }
          update();
        }
      }
      update();
    }
    
    setPackage(){
      if(user.packageId!=null){
        package=Get.find<PropertiesController>().packages.firstWhere((element) => element.id==user.packageId);
      }
    }

    updateUser()async{
      Show.showLoader();
      if(imageUrl!=null){
        loadingImage=true;
        update();
        String image=await Get.find<FireBaseStorageService>().uploadImage(imageUrl!);
        user.imageUrl=image;
        loadingImage=false;
        update();
      }
      await Get.find<FireStoreService>().updateUser(user);
      setUser();
      if(Get.isOverlaysOpen){
        Get.back();
      }
    }

    setUser(){
      imageUrl=null;
      user=AppUser.fromJson(Get.find<UserController>().currentUser.value.toMap(), Get.find<UserController>().currentUser.value.id!);
      user.superHotAdNumbers=Get.find<UserController>().currentUser.value.superHotAdNumbers;
      user.hotAdNumbers=Get.find<UserController>().currentUser.value.hotAdNumbers;
    }

    @override
  void onInit() {
    setUser();
    setPackage();
    super.onInit();
  }
}