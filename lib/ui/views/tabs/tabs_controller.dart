
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/filter/filter_controller.dart';
import 'package:propertychowk/ui/views/filter/filter_view.dart';
import 'package:propertychowk/ui/views/filter/filteroptions_view.dart';
import 'package:propertychowk/ui/views/groupchat/groupchat_view.dart';
import 'package:propertychowk/ui/views/home/home_view.dart';
import 'package:propertychowk/utils/show.dart';

class TabsController extends GetxController{
  int index=0;
  bool confirmPop=false;
  List<Widget> views=[
    HomeView(),
    FilterView(),
    GroupChatView()
  ];
  void changeTab(int newIndex){
    index=newIndex;
    if(index==1){
     // Get.find<FilterController>().setFilter();
      Get.find<FilterController>().setCity();
      Get.find<FilterController>().filteredProperties=null;
      Get.to(()=>FilterOptions(),transition: Transition.downToUp,duration: Duration(seconds: 1));
    }else{
      Get.find<FilterController>().setFilter();
    }
    if(confirmPop){
      confirmPop=false;
    }
    update();
  }



  Future<bool> checkBackButtonFunctionality()async{
    if(index==0 && !confirmPop){
      Show.showSnackBar("Message","press back button again to exit");
      confirmPop=true;
      await Future.delayed(Duration(seconds: 1));
      return false;
    }else if (index==0 && confirmPop){
      return true;
    }
    else{
      if(index==1){
        //Get.find<FilterController>().setFilter();
        Get.find<FilterController>().setCity();
        Get.find<FilterController>().filteredProperties=null;
        Get.to(()=>FilterOptions(),transition: Transition.downToUp,duration: Duration(seconds: 1));
      }
      else{
        changeTab(0);
      }
      return false;
    }
  }


}