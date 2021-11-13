import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/filter/filter_controller.dart';
import 'package:propertychowk/ui/views/filter/filteroptions_view.dart';
import 'package:propertychowk/ui/views/home/home_controller.dart';
import 'package:propertychowk/ui/views/propertyThumbnail/propertythumbnail_view.dart';
import 'package:propertychowk/ui/views/tabs/tabs_controller.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/utils/styles.dart';

class FilterView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  GetBuilder<FilterController>(
        init: FilterController(),
        builder: (controller){
          return Scaffold(


            appBar: AppBar(
           leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined,),onPressed: (){

             Get.back();
             Get.to(()=>FilterOptions());
            },),
              title: AutoSizeText("Searched Properties(${controller.filteredProperties?.length??"0"})",style: TextStyles.title1.copyWith(color: Colors.black),),
            ),
            body: controller.filteredProperties==null?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.2),
                child: RippleButton(
                  width: Get.width*1,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (){
                    Get.to(()=>FilterOptions(),transition: Transition.downToUp,duration: Duration(seconds: 1));
                  },title: "Search",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
              ),
            ],):SafeArea(
              child: controller.filteredProperties!.length==0?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText("Cannot find any property",style: TextStyles.h2,),
                  SizedBox(height: Get.height*0.05,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.2),
                    child: RippleButton(
                      width: Get.width*1,
                      borderRadius: BorderRadius.circular(10),
                      onPressed: (){
                        Get.to(()=>FilterOptions(),transition: Transition.downToUp,duration: Duration(seconds: 1));
                      },title: "Search Again",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
                  ),
                ],)
                  :ListView.builder(
                padding: EdgeInsets.symmetric(horizontal:Get.width*0.05),
                  itemCount: controller.filteredProperties!.length,
                  itemBuilder: (_,index){

                //  controller.filteredProperties?.sort((a,b)=>b.date!.day.compareTo(a.date!.day));
                return PropertyThumbnailView(controller.filteredProperties![index]);
              }),
            ),
          );
        });
  }
}
