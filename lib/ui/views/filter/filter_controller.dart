
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:propertychowk/core/controllers/properties_controller.dart';
import 'package:propertychowk/core/services/localstorage_service.dart';
import 'package:propertychowk/models/filter.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/utils/show.dart';

class FilterController extends GetxController{
  late Filter filter;
  late List subPropertyType;
  late TextEditingController cityController;
  late TextEditingController societyController;
  List<Property>? filteredProperties;
  late TextEditingController  minPrice;
  late TextEditingController  maxPrice;
  late TextEditingController  phase;
  late TextEditingController  block;
  late TextEditingController sector;
  late TextEditingController mohallah;
  late TextEditingController area;
  late TextEditingController road;
  late TextEditingController street;
  List<String> areaTypes=["Sq.ft","Yards", "Marla","Kanal","Acre"];
  List<Map> convertedAreas=[];
  @override
  void onClose() {
    street.dispose();
    road.dispose();
    area.dispose();
    mohallah.dispose();
    sector.dispose();
    block.dispose();
    phase.dispose();
    cityController.dispose();
    societyController.dispose();
    minPrice.dispose();
    maxPrice.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    street=TextEditingController();
    road=TextEditingController();
    area=TextEditingController();
    mohallah=TextEditingController();
    sector=TextEditingController();
    block=TextEditingController();
    phase=TextEditingController();
    cityController=TextEditingController();
    societyController=TextEditingController();
    minPrice=TextEditingController();
    maxPrice=TextEditingController();
   setFilter();
    subPropertyType=Property.plotsPropertyTypes;
    super.onInit();
  }

  setCity(){
    cityController.text=Get.find<LocalStorageService>().getLocation()??"";
    if(cityController.text.isNotEmpty){
      filter.city=cityController.text;
    }
  }

  setFilter(){
   filter=Filter();
    filter.purpose=0;
   filter.minPrice=0;
   filter.maxPrice=1000000000;
   filter.areaType="Marla";
   area.clear();
    road.clear();
   phase.clear();
   block.clear();
   sector.clear();
   street.clear();
   minPrice.clear();
   maxPrice.clear();
   filter.features=[];
   filter.propertyType=Property.propertyTypes[0]['name'];
   subPropertyType=Property.plotsPropertyTypes;
   cityController.clear();
   societyController.clear();
    update();
  }
  changePropertyFilterPurpose(int index){
    if(index==1 && filter.propertyType=="Home"){
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
      filter.propertyType=Property.propertyTypes[0]['name'];
      subPropertyType=Property.plotsPropertyTypes;
    }
    filter.propertySubType=null;
    filter.purpose=index;
    update();
  }

  changePropertyType(String type){
    filter.propertyType=type;
    switch(type){
      case "Plot":
        subPropertyType=Property.plotsPropertyTypes;
        break;
      case "Home":
        subPropertyType=filter.purpose==1?Property.homePropertyTypes+[{
          "name":"Upper Portion",
          "icon":FontAwesomeIcons.building,
        },
          {
            "name":"Lower Portion",
            "icon":FontAwesomeIcons.home
          },]:Property.homePropertyTypes;
        break;
      case "Commercial":
        subPropertyType=Property.commercialPropertyType;
        break;
      case "Farm House":
        subPropertyType=Property.farmHouseTypes;
        break;
    }
    update();
  }



  changePropertySubType(String subType){
    filter.propertySubType=subType;
    update();
  }

  sortProperties(){
    Show.showLoader();
    List<Property> properties=List.from(Get.find<PropertiesController>().properties);
    List<Property> pairedProperties=properties.where((element) => element.propertyNumber==null?false:element.propertyNumber!.split(",").length>1).toList();
    print(pairedProperties.length);
    filteredProperties=properties.where((element) => element.purpose==filter.purpose).toList();
    filteredProperties=filteredProperties!.where((element) => element.propertyType==filter.propertyType).toList();
    if(filter.city!=null){
      filteredProperties=filteredProperties!.where((element) => element.city==filter.city).toList();
    }
    if(filter.society!=null){
      filteredProperties=filteredProperties!.where((element) => element.society==filter.society).toList();
    }
    if(filter.propertySubType!=null){
      filteredProperties=filteredProperties!.where((element) => element.propertySubType==filter.propertySubType).toList();
    }
    if(minPrice.text!=""){
      filteredProperties=filteredProperties!.where((element) => double.parse(element.propertyPrice.toString())>=double.parse(minPrice.text)).toList();
    }
    if(maxPrice.text!=""){
      filteredProperties=filteredProperties!.where((element) => double.parse(element.propertyPrice.toString())<=double.parse(maxPrice.text)).toList();
    }
    if(filter.area!=null && filter.areaType!=null){
      if(filter.area!.isNotEmpty && filter.areaType!.isNotEmpty){
        double calculatingArea=Property.getCalculatingArea(filter.areaType!, filter.area!);
        filteredProperties=filteredProperties!.where((element) => element.calculatingArea==calculatingArea).toList();
      }
    }

    if(filter.phase!=null){
      if(filter.phase!.isNotEmpty){
        filteredProperties=filteredProperties!.where((element) => element.phase!.toString().toLowerCase().trim()==filter.phase!.toLowerCase().trim()).toList();
      }
    }
    if(filter.block!=null){
      if(filter.block!.isNotEmpty){
        filteredProperties=filteredProperties!.where((element) => element.block!.toLowerCase().trim()==filter.block!.toLowerCase().trim()).toList();
      }
    }
    if(filter.sector!=null){
      if(filter.sector!.isNotEmpty){
        filteredProperties=filteredProperties!.where((element) => element.sector!.toLowerCase().trim()==filter.sector!.toLowerCase().trim()).toList();
      }
    }
    if(filter.road!=null){
      if(filter.road!.isNotEmpty){
        filteredProperties=filteredProperties!.where((element) => element.road!.toLowerCase().trim()==filter.road!.toLowerCase().trim()).toList();
      }
    }
    if(filter.street!=null){
      if(filter.street!.isNotEmpty){
        filteredProperties=filteredProperties!.where((element) => element.street!.toLowerCase().trim()==filter.street!.toLowerCase().trim()).toList();
      }
    }
    if(filter.bedrooms!=null){
      if(filter.bedrooms!.isNotEmpty){
        filteredProperties=filteredProperties!.where((element) => element.bedrooms==filter.bedrooms).toList();
      }
    }
    if(filter.bathrooms!=null){
      filteredProperties=filteredProperties!.where((element) => element.bathrooms==filter.bathrooms).toList();
    }
    if(filter.floor!=null){
      filteredProperties=filteredProperties!.where((element) => element.floor==filter.floor).toList();
    }


    if(filter.features!.contains("Pair") || filter.features!.contains("Triple")||filter.features!.contains("Tetra")){
      filteredProperties=filteredProperties!.where((element) => element.propertyNumber!.split(",").length==2 && filter.features!.contains("Pair")||element.propertyNumber!.split(",").length==3 && filter.features!.contains("Triple")||element.propertyNumber!.split(",").length==4 && filter.features!.contains("Tetra")).toList();
      filter.features!.remove("Pair");
      filter.features!.remove("Triple");
      filter.features!.remove("Tetra");
    }

    if(filter.features!.length>0){
      filteredProperties=filteredProperties!.where((element) => element.propertyFeatures!.toSet().intersection(filter.features!.toSet()).length>0).toList();
    }


    List<Property> sortedProperties=[];
    sortedProperties.addAll(filteredProperties!.where((element) => element.featureType==0));
    sortedProperties.addAll(filteredProperties!.where((element) => element.featureType==1));
    sortedProperties.addAll(filteredProperties!.where((element) => !element.featured!));
    filteredProperties!.clear();
    filteredProperties!.addAll(sortedProperties);
     Get.back();
    update();
  }

  getConvertedArea(val){
    areaTypes.forEach((element) {
      if(filter.areaType=="Sq.ft"){
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
      else if(filter.areaType=="Yards"){
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
      else if(filter.areaType=="Marla"){

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
      else if(filter.areaType=="Kanal"){
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
      else if(filter.areaType=="Acre"){
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

}