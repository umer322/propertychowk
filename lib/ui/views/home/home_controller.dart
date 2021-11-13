
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/services/localstorage_service.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/widgets/search_society.dart';
import 'package:propertychowk/utils/colors.dart';
import 'package:propertychowk/utils/styles.dart';

class HomeController extends GetxController{
  String waterMark="propertychowk.com";
  late List<Property> properties;
  late List<Property> superHotProperties;
  late List<Property> hotProperties;
  late TextEditingController societyController;
  late StreamSubscription propertiesListener;
  listenToProperties(){
    properties=Get.find<PropertiesController>().properties;
    superHotProperties=Get.find<PropertiesController>().properties.where((element) => element.featured! && element.featureType==0).toList();
    hotProperties=Get.find<PropertiesController>().properties.where((element) => element.featured! && element.featureType==1).toList();
    propertiesListener=Get.find<PropertiesController>().properties.listen((data) {
      properties=data;
      superHotProperties=data.where((element) => element.featured! && element.featureType==0).toList();
      hotProperties=data.where((element) => element.featured! && element.featureType==1).toList();
      update();
    });
  }

  removeCityAndSociety(){
    Get.find<LocalStorageService>().setCity(null);
    Get.find<LocalStorageService>().setSociety(null);
    societyController.clear();
    listenToProperties();
    update();
  }

  setCity(String city){
    Get.find<LocalStorageService>().setCity(city);
    setCityProperties(city);
    update();
  }

  setSociety(String city,String society){
    Get.find<LocalStorageService>().setSociety(society);
    setSocietyProperties(city,society);
    update();
  }
  setCityProperties(String city){
    societyController.text=city;
    properties=Get.find<PropertiesController>().properties.where((e) => e.city==city).toList();
    superHotProperties=properties.where((element) => element.featured! && element.featureType==0).toList();
    hotProperties=properties.where((element) => element.featured! && element.featureType==1).toList();
    update();
  }

  setSocietyProperties(String city,String society){
    societyController.text=society;
    properties=Get.find<PropertiesController>().properties.where((e) => e.city==city && e.society==society).toList();
    superHotProperties=properties.where((element) => element.featured! && element.featureType==0).toList();
    hotProperties=properties.where((element) => element.featured! && element.featureType==1).toList();
    update();
  }


  showDeletePopup(){
    Get.defaultDialog(
      title: "Remove City and Society",
      titleStyle: TextStyles.h2.copyWith(color: Colors.black),
      content: AutoSizeText("Are you sure you want to delete?"),
      actions: [
        TextButton(onPressed: ()async{
          Get.back();
          String? city=await Get.find<LocalStorageService>().getCity();
          if(city!=null){
            print(city);
            String? society=await Get.to(()=>SearchSociety(city),preventDuplicates: false);
            if(society!=null){
              setSociety(city, society);
            }
          }
        },style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: primaryColor))
        ), child: Text("Change Society")),
        TextButton(style: ButtonStyle(
    side: MaterialStateProperty.all(BorderSide(color: primaryColor))
    ),onPressed: (){
          removeCityAndSociety();
          Get.back();
        }, child: Text("Yes")),
        TextButton(style: ButtonStyle(
    side: MaterialStateProperty.all(BorderSide(color: primaryColor))
    ),onPressed: (){
          Get.back();
        }, child: Text("No")),
      ],
        buttonColor: primaryColor,
    );
  }

  initPropertyList()async{
    String? city=await Get.find<LocalStorageService>().getCity();
    if(city!=null){
      setCityProperties(city);
    }
    String? society=await Get.find<LocalStorageService>().getSociety();
    if(society!=null){
      setSocietyProperties(city!, society);
    }
  }

  @override
  void onClose() {
    propertiesListener.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    societyController=TextEditingController();
    listenToProperties();
    initPropertyList();
    super.onInit();
  }
}