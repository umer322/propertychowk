

import 'dart:async';

import 'package:get/get.dart';
import 'package:propertychowk/core/services/firebasedatabase_service.dart';
import 'package:propertychowk/core/services/firebasestorage_service.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/models/package.dart';
import 'package:propertychowk/models/property.dart';

class PropertiesController extends GetxService{
  RxList<Package> packages=RxList();
  RxList<Property> properties=RxList();

  late StreamSubscription packagesStream;
  late StreamSubscription propertyAddedSubscription;
  late StreamSubscription propertyRemovedSubscription;
  late StreamSubscription propertyUpdatedSubscription;
  listenToPackages(){
        packagesStream=Get.find<FireStoreService>().packagesStream().listen((event) {
         packages.addAll(event.docs.map((e) => Package.fromJson(Map.from(e.data() as Map), e.id)).toList());
        });
  }


 Future uploadProperty(Property property)async{
      try{
        List<String> images=await Get.find<FireBaseStorageService>().uploadMultipleImages(property.propertyImages!);
        property.propertyImages=images;
        if(property.propertyVideo!=null){
         String? video=await Get.find<FireBaseStorageService>().uploadImage(property.propertyVideo!);
          if(video!=null){
            property.propertyVideo=video;
          }
          if(property.localPropertyThumbnail!=null){
            String? image=await Get.find<FireBaseStorageService>().uploadThumbnail(property.localPropertyThumbnail!);
            if(image!=null){
              property.propertyVideoThumbnail=image;
            }
          }
        }

        if(property.id!=null){
          await Get.find<FireBaseDatabaseService>().updateProperty(property);
        }
        else{

          await Get.find<FireBaseDatabaseService>().uploadProperty(property);
        }
      }
      catch(e){
        rethrow;
      }
  }


  getAllProperties()async{
   List<Property> newProperties= await Get.find<FireBaseDatabaseService>().getAllProperties();
   newProperties.sort((a,b){
     return b.date!.compareTo(a.date!);
   });
   properties.addAll(newProperties);
   propertyAddedSubscription=Get.find<FireBaseDatabaseService>().onPropertiesAddedStream().listen((event) {
     int index=properties.indexWhere((element) => element.id==event.snapshot.key);
     if(index==-1){
       properties.insert(0,Property.fromJson(Map.from(event.snapshot.value), event.snapshot.key!));

     }
   });

   propertyUpdatedSubscription=Get.find<FireBaseDatabaseService>().onPropertiesUpdateStream().listen((event) {
     int index=properties.indexWhere((element) => element.id==event.snapshot.key,);
     if(index!=-1){
       properties[index]=Property.fromJson(Map.from(event.snapshot.value), event.snapshot.key!);
     }
     properties.sort((a,b){
       return b.date!.compareTo(a.date!);
     });
   });
   propertyRemovedSubscription=Get.find<FireBaseDatabaseService>().onPropertiesRemovedStream().listen((event) {
     properties.removeWhere((element) => element.id==event.snapshot.key);
   });
  }



  @override
  void onInit() {
    listenToPackages();
    getAllProperties();
    super.onInit();
  }

  @override
  void onClose() {
    propertyAddedSubscription.cancel();
    propertyRemovedSubscription.cancel();
    propertyUpdatedSubscription.cancel();
    packagesStream.cancel();
    super.onClose();
  }
}