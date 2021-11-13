import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/myproperties/myproperties_controller.dart';
import 'package:propertychowk/ui/views/propertyThumbnail/propertythumbnail_view.dart';
import 'package:propertychowk/utils/styles.dart';


class MyPropertiesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPropertiesController>(builder: (controller){
      return Scaffold(
        appBar: AppBar(
          title: AutoSizeText("My Properties(${controller.myProperties.length})",style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body:controller.myProperties.length==0?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AutoSizeText("You don't have any property",style: TextStyles.h2,textAlign: TextAlign.center,),
              ],):SafeArea(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal:Get.width*0.05),
                  itemCount: controller.myProperties.length,
                  itemBuilder: (_,index){
                    return PropertyThumbnailView(controller.myProperties[index]);
                  }),
            )
      );
    });
  }
}
