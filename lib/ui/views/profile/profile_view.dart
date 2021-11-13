import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/profile/profile_controller.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/utils/styles.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
title:

Image.asset("assets/mawjoodIcon.png",width: Get.width*0.3,),


        centerTitle: true,
        elevation: 0.0,
        backgroundColor:Color(0xfff5f6fa) ,),
      backgroundColor: Color(0xfff5f6fa),
      body: GetBuilder<ProfileController>(builder: (controller){
        return SingleChildScrollView(
          child: Container(
            height: Get.height,
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight/2,),
                // Row(children: [
                //   IconButton(onPressed: (){
                //     Get.back();
                //   }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
                //   Expanded(
                //       flex: 2,
                //       child: SizedBox()),
                //   AutoSizeText("Profile",style: TextStyles.h2,),
                //   Expanded(
                //       flex: 3,
                //       child: SizedBox())
                // ],),

                Text("Profile",style: TextStyles.h3.copyWith(color: Colors.black),),
                SizedBox(height: Get.height*0.05,),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),
                        margin: EdgeInsets.only(top: Get.height*0.075),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:Get.width*0.05),
                          child: Column(
                            children: [
                              SizedBox(height: Get.height*0.07,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    GestureDetector(
                                      onTap: controller.toggleEdit,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Theme.of(context).primaryColor
                                        ),
                                        child: Center(
                                          child: AutoSizeText(controller.edit?"Done":"Edit",style: TextStyles.title1.copyWith(color: Colors.white),),
                                        ),
                                      ),
                                    )
                                   ],),
                              TextFormField(
                                readOnly: !controller.edit,
                                initialValue: controller.user.name,
                                onChanged: (val){
                                  controller.user.name=val;
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  prefixIcon: Icon(Icons.person,color: Theme.of(context).primaryColor,),
                                  hintText: "Name",
                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              TextFormField(
                                readOnly: true,
                                initialValue: controller.user.email,
                                decoration: InputDecoration(
                                  filled: false,
                                  prefixIcon: Icon(Icons.email,color: Theme.of(context).primaryColor,),
                                  hintText: "Email",
                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              TextFormField(
                                readOnly: !controller.edit,
                                initialValue: controller.user.phoneNumber,
                                keyboardType: TextInputType.phone,
                                onChanged: (val){
                                  controller.user.phoneNumber=val;
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  prefixIcon: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
                                  hintText: "Phone Number",
                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              TextFormField(
                                readOnly: !controller.edit,
                                initialValue: controller.user.estateName,
                                onChanged: (val){
                                  controller.user.estateName=val;
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  prefixIcon: Icon(Icons.business,color: Theme.of(context).primaryColor,),
                                  hintText: "Estate Name",
                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              controller.package==null?SizedBox():Row(children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText("Package",style: TextStyles.title1,),
                                    SizedBox(height: 7,),
                                    AutoSizeText("${controller.package!.name}",style: TextStyles.body1,presetFontSizes: [18,16],)
                                  ],
                                )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText("Price",style: TextStyles.title1,),
                                    SizedBox(height: 7,),
                                    AutoSizeText("${controller.package!.price} Rs/-",style: TextStyles.body1,presetFontSizes: [18,16],)
                                  ],
                                )
                              ],),
                              SizedBox(height: Get.height*0.02,),
                              controller.user.superHotAdNumbers! > 0||controller.user.hotAdNumbers! > 0?
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                      AutoSizeText("Premium Ads",style: TextStyles.title1,textAlign: TextAlign.center,),
                                        SizedBox(height: Get.height*0.02,),
                                        Row(children: [
                                          Expanded(child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText("Super Hot",style: TextStyles.title1.copyWith(height: 1.71),),
                                              SizedBox(height: 7,),
                                              AutoSizeText("Hot",style: TextStyles.title1.copyWith(height: 1.71),)
                                            ],
                                          )),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText("${controller.user.superHotAdNumbers}",style: TextStyles.body1,presetFontSizes: [18,16],),
                                              SizedBox(height: 7,),
                                              AutoSizeText("${controller.user.hotAdNumbers}",style: TextStyles.body1,presetFontSizes: [18,16],)
                                            ],
                                          )
                                        ],),
                                    ],),
                                  )
                                  :SizedBox(),
                              SizedBox(height: Get.height*0.02,),
                              controller.edit?RippleButton(
                                width: Get.width*1,
                                borderRadius: BorderRadius.circular(35),
                                onPressed:
                                controller.updateUser
                                ,title: "Update",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,):SizedBox(),
                            ],
                          ),
                        ),
                      )),
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: Get.height*0.15,
                                  width: Get.height*0.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                      shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: controller.imageUrl!=null?Image.file(File(controller.imageUrl!,),fit: BoxFit.cover,):controller.user.imageUrl!=null?CachedNetworkImage(imageUrl: controller.user.imageUrl!,fit: BoxFit.cover,):Image.asset("assets/person.png",fit: BoxFit.cover,),
                                  ),
                                ),
                              controller.edit&&!controller.loadingImage?Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: controller.setImage,
                                    child: Container(
                                height: Get.width*0.1,
                                width: Get.width*0.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Icon(Icons.camera_alt,color: Theme.of(context).primaryColor,),),
                              ),
                                  )):SizedBox()
                              ],
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
