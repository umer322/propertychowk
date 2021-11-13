import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/models/user.dart';
import 'package:propertychowk/ui/views/videoplayer/videoplayer_view.dart';
import 'package:propertychowk/utils/show.dart';
import 'package:propertychowk/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailController extends GetxController{
  Property property;
  PropertyDetailController(this.property);
  List<Widget> images=[];
  int index=0;
  bool showMore=false;
  final CarouselController carouselController = CarouselController();
  AppUser? seller;
  late StreamSubscription propertiesListener;

  listenToProperty(){
    propertiesListener=Get.find<PropertiesController>().properties.listen((data) {
     Property updatedProperty=data.firstWhere((element) => element.id==property.id,orElse: null);
       property=updatedProperty;
        setImages();
    });
  }

  toggleShowMore(){
    showMore=!showMore;
    update();
  }

  getSellerData()async{
    try{
      if(property.sellerId==Get.find<UserController>().currentUser.value.id){
        seller=Get.find<UserController>().currentUser.value;
      }
      else{
        seller=await Get.find<FireStoreService>().getUserData(property.sellerId!);
      }
      update();
    }
    catch(e){
      print(e);
      Show.showErrorSnackBar("Error", e as String);
    }
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  setImages()async{
    images=property.propertyImages!.map((e) => Container(
        height: Get.height*0.25,
        width: Get.width,
        child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(imageUrl: e,fit: BoxFit.cover,),
            )))).toList();
    if(property.propertyVideo!=null && property.propertyVideoThumbnail!=null){
      images.add(Container(
        height: Get.height*0.25,
        width: Get.width,
        child: GestureDetector(
          onTap: (){
            Get.to(()=>VideoViewer(property.propertyVideo!));
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(imageUrl: property.propertyVideoThumbnail!,),
                  )),
              Positioned(
                  right:0,
                  bottom: 0,
                  left:0,
                  top:0,
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                      child: Icon(Icons.play_arrow,color: Colors.black,),
                    ),
                  )),
            ],
          ),
        ),
      ));
    }
    update();
  }

  showPopup(){
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.close,color: Colors.black,)),),
          ListTile(
            leading: Icon(Icons.phone),
            title: AutoSizeText("Call"),
            onTap: (){
             launchURL("tel:${property.optionalNumber}");
            },
          ),
          ListTile(
            leading: Image.asset("assets/whatsapp.png"),
            title: AutoSizeText("Whatsapp"),
            onTap: (){
              launchURL("whatsapp://send?phone=${property.optionalNumber}");
            },
          ),
        ],
      ),
    ));
  }

  @override
  void onInit() {
    setImages();
    getSellerData();
    listenToProperty();
    super.onInit();
  }

  @override
  void onClose() {
    propertiesListener.cancel();
    super.onClose();
  }

   Widget addCard({String? title, String? value,Color? color,double? height}){
     return Card(
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(0.0),
      ),

      margin: EdgeInsets.zero,
      elevation: 1.0,

      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Text(title!,     style: TextStyles.h3,)),
            Expanded(
              flex: 3,
              child: Text(" ${value??0}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.black)),
            )

          ],
        ),
      ),
    );

  }
}