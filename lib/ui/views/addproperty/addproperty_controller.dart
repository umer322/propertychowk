
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/core/services/localstorage_service.dart';
import 'package:propertychowk/core/services/multimedia_service.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/models/user.dart';
import 'package:propertychowk/utils/colors.dart';
import 'package:propertychowk/utils/show.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:number_to_words/number_to_words.dart';

class AddPropertyController extends GetxController{

 GlobalKey<FormState> formKey=GlobalKey<FormState>();
 List<String> areaTypes=["Sq.ft","Yards", "Marla","Kanal","Acre"];
 late TextEditingController societyController;
 late TextEditingController cityController;
 bool pair1=false;
 bool pair2=false;
 bool pair3=false;
 List<Map> convertedAreas=[];
 List<Widget> pairedList=[];
 int pairValue=1;
 String? propertyNumber1;
 String? propertyNumber2;
 String? propertyNumber3;
 String? propertyNumber4;
 Uint8List? videoThumbnail;
 late List subPropertyType;
 Property property;
 bool edit=false;
 AddPropertyController(this.property);

 changePropertySellPurpose(int index){
  if(index==1 && property.propertyType=="Home"){
   subPropertyType=Property.homePropertyTypes+[{
    "name":"Upper Portion",
    "icon":FontAwesomeIcons.building,
   },
    {
     "name":"Lower Portion",
     "icon":FontAwesomeIcons.home
    },];
  }
  else {
   property.propertyType=Property.propertyTypes[0]['name'];
   subPropertyType=Property.plotsPropertyTypes;
  }
  property.propertySubType="";
  property.purpose=index;
  update();
 }

 changePropertyFeatureType(int index){
  if(property.featureType==index){
   property.featureType=null;
  }
  else{
   property.featureType=index;
  }
  update();
 }
 changePropertyType(String type){
  property.propertySubType=null;
  property.propertyType=type;
  switch(type){
   case "Plot":
    subPropertyType=Property.plotsPropertyTypes;
    break;
   case "Home":
    checkPropertyNumberLogic();
    subPropertyType=property.purpose==1?Property.homePropertyTypes+[{
     "name":"Upper Portion",
     "icon":FontAwesomeIcons.building,
    },
     {
      "name":"Lower Portion",
      "icon":FontAwesomeIcons.home
     },]:Property.homePropertyTypes;
    break;
   case "Commercial":
    checkPropertyNumberLogic();
    subPropertyType=Property.commercialPropertyType;
    break;
   case "Farm House":
    checkPropertyNumberLogic();
    subPropertyType=Property.farmHouseTypes;
    break;
  }
  update();
 }

 checkPropertyNumberLogic(){
  if(pairValue>1){
   pairValue=1;
   pair1=false;
   pair2=false;
   pair3=false;
   propertyNumber1=null;
   propertyNumber2=null;
   propertyNumber3=null;
   propertyNumber4=null;

   pairedList=[
    TextField(
     onChanged: (val){
      propertyNumber1=val;
     },
     decoration: InputDecoration(
         fillColor: Colors.white,
         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
         errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
         focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
     ),
    ),
   ];
  }
  update();
 }


 loadImages(BuildContext context)async{
  var data= await Get.find<MultiMediaService>().getImages(context,10-property.propertyImages!.length);
  if(data!=null){
   property.propertyImages!.addAll(data);
   update();
  }
 }


 loadVideo(BuildContext context)async{
  var data= await Get.find<MultiMediaService>().getVideo(context);
  if(data!=null){
   property.propertyVideo=data[0];
   loadThumbnail(property.propertyVideo!);
  }
 }

 loadThumbnail(String url)async{
   final uint8list = await VideoThumbnail.thumbnailData(
     video: url,
     imageFormat: ImageFormat.JPEG,
     maxWidth: 300,
     maxHeight: 300,// specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
     quality: 50,
   );
   property.localPropertyThumbnail=uint8list;
   videoThumbnail=uint8list;
   update();
 }


 changePropertySubType(String subType){
   property.propertySubType=subType;
   update();
 }

 @override
  void onClose() {

    societyController.dispose();
    cityController.dispose();
    super.onClose();
  }




  uploadProperty()async{
  if(property.updatedCount!=null){
   if(property.updatedCount==0){
    Show.showErrorSnackBar("Error", "You cannot update this property anymore");
    return;
   }
  }
   property.calculatingArea=Property.getCalculatingArea(property.areaType!,property.propertyArea!);
   String propertyNumber="";
    if(propertyNumber1!=null){
     propertyNumber=propertyNumber1!.trim();
    }
    if(propertyNumber2!=null){
     propertyNumber=propertyNumber+",${propertyNumber2!.trim()}";
    }
    if(propertyNumber3!=null){
     propertyNumber=propertyNumber+",${propertyNumber3!.trim()}";
    }
    if(propertyNumber4!=null){
     propertyNumber=propertyNumber+",${propertyNumber4!.trim()}";
    }
    property.propertyNumber=propertyNumber;
   if(!edit){
    property.updatedCount=3;
    if(property.featured!){
     AppUser user=AppUser.fromJson(Get.find<UserController>().currentUser.value.toMap(), Get.find<UserController>().currentUser.value.id!);
     user.superHotAdNumbers=Get.find<UserController>().currentUser.value.superHotAdNumbers;
     user.hotAdNumbers=Get.find<UserController>().currentUser.value.hotAdNumbers;
      if(property.featureType==0){
       user.superHotAdNumbers=user.superHotAdNumbers!-1;
       Get.find<FireStoreService>().updateUser(user);
      }
      else{
       user.hotAdNumbers=user.hotAdNumbers!-1;
       Get.find<FireStoreService>().updateUser(user);
      }
    }
    property.sellerId=Get.find<UserController>().currentUser.value.id;
   }else{
    if(property.updatedCount==null){
     property.updatedCount=3;
    }
    property.updatedCount=property.updatedCount!-1;

   }
   property.date=DateTime.now();
   print("changing time");
   try{
    Show.showLoader();
    await Get.find<PropertiesController>().uploadProperty(property).then((value) => Get.back());
    if(Get.isOverlaysOpen){
     Get.back();
    }
    Get.back();
   }
   catch(e){
    if(Get.isOverlaysOpen){
     Get.back();
    }
    print(e);
    Show.showErrorSnackBar("Error", "Cannot upload property right now");
   }
  }

  initializePropertyValues(){
   property=Property();
   property.purpose=0;
   property.propertyType=Property.propertyTypes[0]['name'];
   property.status=[];
   property.areaType="Marla";
   property.propertyImages=[];
   property.propertyFeatures=[];
   property.propertyPrice="";
   property.featured=false;
   pairedList=[
    TextField(
     onChanged: (val){
     propertyNumber1=val;
     },
     decoration: InputDecoration(
         fillColor: Colors.white,
         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
         errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
         focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
     ),
    ),
   ];
  }

  showBottomPopup(){
     Get.bottomSheet(Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.width*0.05),
      decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
        ListTile(
         onTap: (){
          Get.back();
          if(property.propertyImages!.length==10){
           Show.showErrorSnackBar("Error", "You cannot select more than 10 images");
          }
          loadImages(Get.context!);
         },
         leading: Icon(Icons.image),
         title: AutoSizeText("Upload Pictures"),
        ),
        ListTile(
         onTap: (){
          Get.back();
          loadVideo(Get.context!);
         },
         leading: Icon(Icons.video_library),
         title: AutoSizeText("Upload Video"),
        ),
       ],
      ),
     ));
  }

 handlePairChange(val){

  pairValue=val;
  if(pairValue==2){
   propertyNumber4=null;
   propertyNumber3=null;
   pairedList=[TextFormField(
    initialValue: propertyNumber1,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber1=val;
    },),TextFormField(
    initialValue: propertyNumber2,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber2=val;
    },
   )];
  }
  if(pairValue==3){
   propertyNumber4=null;
   pairedList=[TextFormField(
    initialValue: propertyNumber1,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber1=val;
    },),TextFormField(
    initialValue: propertyNumber2,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber2=val;
    },
   ),TextFormField(
    initialValue: propertyNumber3,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber3=val;
    },
   )];
  }
  if(pairValue==4){
   pairedList=[TextFormField(
    initialValue: propertyNumber1,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber1=val;
    },),TextFormField(
    initialValue: propertyNumber2,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber2=val;
    },
   ),TextFormField(
    initialValue: propertyNumber3,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber3=val;
    },
   ),TextFormField(
    initialValue: propertyNumber4,
    decoration: InputDecoration(
     fillColor: Colors.white,
     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
     errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
     border:UnderlineInputBorder(
         borderSide:  BorderSide(
             color: Colors.red,
             width: 2
         )
     ),
    ),
    onChanged: (val){
     propertyNumber4=val;
    },)];
  }
  update();
 }


 @override
  void onInit() {
  societyController = TextEditingController();
  cityController = TextEditingController();
  if (property.id != null) {
   edit = true;
   property=Property.fromJson(property.toMap(), property.id!);
   String subType=property.propertySubType!;
   changePropertyType(property.propertyType!);
   property.propertySubType=subType;
   societyController.text = property.society ?? "";
   cityController.text = property.city ?? "";
   if(property.propertyNumber!=null){
    if (property.propertyNumber!.contains(",")) {
     List<String> plotNumbers = property.propertyNumber!.split(",");
     if (plotNumbers.length == 2) {
      pair1 = true;
      pairValue = 2;
      propertyNumber1 = plotNumbers[0];
      propertyNumber2 = plotNumbers[1];
      handlePairChange(2);
     }
     else if (plotNumbers.length == 3) {
      pair2 = true;
      propertyNumber1 = plotNumbers[0];
      propertyNumber2 = plotNumbers[1];
      propertyNumber3 = plotNumbers[2];
      pairValue = 3;
      handlePairChange(3);
     }
     else if (plotNumbers.length == 4) {
      pair3 = true;
      pairValue = 4;
      propertyNumber1 = plotNumbers[0];
      propertyNumber2 = plotNumbers[1];
      propertyNumber3 = plotNumbers[2];
      propertyNumber4 = plotNumbers[3];
      handlePairChange(4);
     }
    }
    else{
     propertyNumber1=property.propertyNumber;
     pairedList=[
      TextFormField(
       initialValue: propertyNumber1,
       onChanged: (val){
        propertyNumber1=val;
       },
       decoration: InputDecoration(
           fillColor: Colors.white,
           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
           errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
           focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
       ),
      ),
     ];
    }
   }else{
    propertyNumber1=property.propertyNumber;
    pairedList=[
     TextFormField(
      initialValue: propertyNumber1,
      onChanged: (val){
       propertyNumber1=val;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
      ),
     ),
    ];
   }
  }
   else {
    initializePropertyValues();
    cityController.text=Get.find<LocalStorageService>().getLocation()??"";
    if(cityController.text.isNotEmpty){
     print(cityController.text);
     property.city=cityController.text;
    }
    subPropertyType = Property.plotsPropertyTypes;
   }
   super.onInit();
  }


 String setCustomPrice(String val){
  if(val.length==1){
   return "${NumberToWord().convert('en-in',int.parse(val.substring(0,1)))} only";
  }
  else if(val.length==2){
   return "${NumberToWord().convert('en-in',int.parse(val.substring(0,2)))} only";
  }
  else if(val.length==3){
   return "${NumberToWord().convert('en-in',int.parse(val.substring(0,1)))} hundred ${NumberToWord().convert('en-in',int.parse(val.substring(1,3)))} only";
  }
  else if(val.length==4){
   return "${NumberToWord().convert('en-in',int.parse(val.substring(0,1)))} thousand ${val.substring(1,2)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(1,2)))+" hundred"):""} ${val.substring(2,4)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(2,4)))):""} only";
  }
  else if(val.length==5){
    return "${NumberToWord().convert('en-in',int.parse(val.substring(0,2)))} thousand ${val.substring(2,3)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(2,3)))+" hundred"):""} ${val.substring(3,5)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(3,5)))):""} only";
  }
  else if(val.length==6){

    return "${NumberToWord().convert('en-in',int.parse(val.substring(0,1)))} lac ${val.substring(1,3)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(1,3)))+" thousand"):""} ${val.substring(3,4)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(3,4)))+" hundred"):""} ${val.substring(4,6)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(4,6)))):""} only";

  }
  else if(val.length==7){

    return "${ NumberToWord().convert('en-in',int.parse(val.substring(0,2)))} lac ${val.substring(2,4)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(2,4)))+" thousand":""} ${val.substring(4,5)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(4,5))))+" hundred":""} ${val.substring(5,7)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(5,7)))):""} only";

  }
  else if(val.length==8){
    return "${NumberToWord().convert('en-in',int.parse(val.substring(0,1)))} crore ${val.substring(1,3)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(1,3)))+" lac":""} ${val.substring(3,5)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(3,5)))+" thousand":""} ${val.substring(5,6)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(5,6))))+" hundred":""} ${val.substring(6,8)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(6,8)))):""} only";

  }
  else if(val.length==9){
    return "${NumberToWord().convert('en-in',int.parse(val.substring(0,2)))} crore ${val.substring(2,4)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(2,4)))+" lac":""} ${val.substring(4,6)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(4,6)))+" thousand":""} ${val.substring(6,7)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(6,7))))+" hundred":""} ${val.substring(7,9)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(7,9)))):""} only";
  }
  else if(val.length==10){
   return "${NumberToWord().convert('en-in',int.parse(val.substring(0,1)))} Arab ${val.substring(1,3)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(1,3)))+" crore":""} ${val.substring(3,5)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(3,5)))+" lac":""} ${val.substring(5,7)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(5,7))))+" thousand":""} ${val.substring(7,8)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(7,8))))+" hundred":""} ${val.substring(8,10)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(8,10)))):""} only";
  }
  else if(val.length==11){
   return "${NumberToWord().convert('en-in',int.parse(val.substring(0,2)))} Arab ${val.substring(2,4)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(2,4)))+" crore":""} ${val.substring(4,6)!="00"?NumberToWord().convert('en-in',int.parse(val.substring(4,6)))+" lac":""} ${val.substring(6,8)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(6,8))))+" thousand":""} ${val.substring(8,9)!="0"?(NumberToWord().convert('en-in',int.parse(val.substring(8,9))))+" hundred":""} ${val.substring(9,11)!="00"?(NumberToWord().convert('en-in',int.parse(val.substring(9,11)))):""} only";
  }
  else{
    return val;
  }
 }

 getConvertedArea(val){
  areaTypes.forEach((element) {
   if(property.areaType=="Sq.ft"){
     convertedAreas=[
      {
       "name":"Yards",
       "value":double.parse(val)/9
      },
      {
       "name":"Marla",
       "value":double.parse(val)/225
      },
      {
       "name":"Kanal",
       "value":double.parse(val)/4500
      },
      {
       "name":"Acre",
       "value":double.parse(val)/43560
      }
     ];
   }
   else if(property.areaType=="Yards"){
     convertedAreas=[
      {
       "name":"Sq.ft",
       "value":double.parse(val)*9
      },
      {
       "name":"Marla",
       "value":double.parse(val)/30.25

      },
      {
       "name":"Kanal",
       "value":double.parse(val)/605
      },
      {
       "name":"Acre",
       "value":double.parse(val)/4840
      }
     ];
   }
   else if(property.areaType=="Marla"){

     convertedAreas=[
      {
       "name":"Sq.ft",
       "value":double.parse(val)*225
      },
      {
       "name":"Yards",
       "value":double.parse(val)*30.25
      },
      {
       "name":"Kanal",
       "value":double.parse(val)/20
      },
      {
       "name":"Acre",
       "value":double.parse(val)/160
      }
     ];
   }
   else if(property.areaType=="Kanal"){
     convertedAreas=[
      {
       "name":"Sq.ft",
       "value":double.parse(val)*4500
      },
      {
       "name":"Yards",
       "value":double.parse(val)*500
      },
      {
       "name":"Marla",
       "value":double.parse(val)*20
      },
      {
       "name":"Acre",
       "value":double.parse(val)/8
      }
     ];
   }
   else if(property.areaType=="Acre"){
     convertedAreas=[
      {
       "name":"Sq.ft",
       "value":double.parse(val)*43560
      },
      {
       "name":"Yards",
       "value":double.parse(val)*4840
      },
      {
       "name":"Marla",
       "value":double.parse(val)*160
      },
      {
       "name":"Kanal",
       "value":double.parse(val)*8
      }
     ];
   }
  });
 }

 }
