import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/models/user.dart';
import 'package:propertychowk/utils/show.dart';

class UserController extends GetxService{
  Rx<AppUser> currentUser = Rx<AppUser>(AppUser());
  late StreamSubscription authUserSubscription;
  late StreamSubscription firestoreUserStream;

  bool justLoggedIn=false;
  currentUserStream(){
    authUserSubscription=Get.find<FireBaseAuthService>().fireBaseAuthUserStream().listen((User? event1) {
      if(event1!=null){
        firestoreUserStream = Get.find<FireStoreService>().fireStoreUserStream(event1.uid).listen((event2)async{
          if(event2.exists){
            try{
              currentUser.value = AppUser.fromJson(Map.from(event2.data() as Map), event2.id);
              if(justLoggedIn){
                await checkAndChangeDeviceId();
              }
              await checkDeviceId();
            }
            on Exception catch(exception){
              Show.showErrorSnackBar("User Error", exception.toString());
            }
            catch (e){
              Show.showErrorSnackBar("User Error", e.toString());
            }
          }
        });
      }
      else{
        currentUser.value=AppUser();
      }
    });
  }


  checkDeviceId()async{
    print("coming here");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if(androidInfo.androidId!=currentUser.value.deviceId){
       Future.delayed(Duration(seconds: 5),(){
         Get.offAllNamed("/restricted");
       });
      }
    }
    else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if(iosInfo.identifierForVendor!=currentUser.value.deviceId){
        Get.offAllNamed("/restricted");
      }
    }
  }


  checkAndChangeDeviceId()async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if(androidInfo.androidId!=currentUser.value.deviceId){
        currentUser.value.deviceId=androidInfo.androidId;
        Get.find<FireStoreService>().updateUser(currentUser.value);
      }
    }
    else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if(iosInfo.identifierForVendor!=currentUser.value.deviceId){
        currentUser.value.deviceId=iosInfo.identifierForVendor;
        Get.find<FireStoreService>().updateUser(currentUser.value);
      }
    }
    justLoggedIn=false;
  }

  addFavoriteProperty(String id){
    try{
      if(currentUser.value.favorites!.contains(id)){
        Get.find<FireStoreService>().removeFavorite(currentUser.value.id!,id);
      }
      else{
        Get.find<FireStoreService>().addFavorite(currentUser.value.id!,id);
      }
    }
    catch(e){
      rethrow;
    }
  }

  @override
  void onInit() {
    currentUserStream();
    super.onInit();
  }
  @override
  void onClose() {
    authUserSubscription.cancel();
    firestoreUserStream.cancel();
    super.onClose();
  }
}