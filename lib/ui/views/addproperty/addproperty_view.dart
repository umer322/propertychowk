
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/addproperty/addproperty_controller.dart';
import 'package:propertychowk/ui/widgets/property_status_view.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/ui/widgets/search_cities.dart';
import 'package:propertychowk/ui/widgets/search_society.dart';
import 'package:propertychowk/utils/colors.dart';
import 'package:propertychowk/utils/show.dart';
import 'package:propertychowk/utils/styles.dart';

class AddPropertyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: GetBuilder<AddPropertyController>(builder: (controller){
        return SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: Row(children: [
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
                    Expanded(
                        flex: 2,
                        child: SizedBox()),
                    AutoSizeText("Add Property",style: TextStyles.h2,),
                    Expanded(
                        flex:3,
                        child: SizedBox())
                  ],),
                ),
                SizedBox(height: Get.height*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Flexible(child: GestureDetector(
                        onTap: (){
                          controller.changePropertySellPurpose(0);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 700),
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.06,vertical: 10),
                          decoration: BoxDecoration(
                              color: controller.property.purpose==0?Theme.of(context).primaryColor:Colors.white,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: AutoSizeText("Sell",style: TextStyles.h3.copyWith(color: controller.property.purpose==0?Colors.white:Colors.black),),),
                        ),
                      )),
                      Flexible(child: GestureDetector(
                        onTap: (){
                          controller.changePropertySellPurpose(1);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 700),
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.06,vertical: 10),
                          decoration: BoxDecoration(
                              color: controller.property.purpose==1?Theme.of(context).primaryColor:Colors.white,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: AutoSizeText("Rent",style: TextStyles.h3.copyWith(color: controller.property.purpose==1?Colors.white:Colors.black),),),
                        ),
                      )),
                        // Flexible(child: GestureDetector(
                        //   onTap: (){
                        //     controller.changePropertySellPurpose(2);
                        //   },
                        //   child: AnimatedContainer(
                        //     duration: Duration(milliseconds: 700),
                        //     padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: 10),
                        //     decoration: BoxDecoration(
                        //         color: controller.property.purpose==2?Theme.of(context).primaryColor:Colors.white,
                        //         borderRadius: BorderRadius.circular(25)
                        //     ),
                        //     child: Center(child: AutoSizeText("Requirement",style: TextStyles.h3.copyWith(color: controller.property.purpose==2?Colors.white:Colors.black),),),
                        //   ),
                        // ))
                    ],),
                  )
                ],),
                SizedBox(height: Get.height*0.01,),
               controller.edit?SizedBox():Padding(
                 padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                 child: Obx((){
                   return  Get.find<UserController>().currentUser.value.superHotAdNumbers!>0||Get.find<UserController>().currentUser.value.hotAdNumbers!>0?Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                     AutoSizeText("Feature Property?",style: TextStyles.title1,),
                     Switch(value: controller.property.featured!,onChanged: (val){
                       controller.property.featured=val;
                       controller.property.featureType=null;
                       controller.update();
                     },activeColor: Theme.of(context).primaryColor,)
                   ],):SizedBox();
                 }),
               ),
                controller.edit?SizedBox():SizedBox(height: Get.height*0.01,),
                controller.edit?SizedBox():controller.property.featured!?Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(Get.width*0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Featured",style: TextStyles.title1,),
                      SizedBox(height: Get.height*0.01,),
                      Row(children: [
                        Flexible(child: Get.find<UserController>().currentUser.value.superHotAdNumbers==0?SizedBox():Center(child: AutoSizeText("${Get.find<UserController>().currentUser.value.superHotAdNumbers} Left",style: TextStyles.h3.copyWith(color: Colors.black),),),),
                        Flexible(child: Get.find<UserController>().currentUser.value.hotAdNumbers==0?SizedBox():Center(child: AutoSizeText("${Get.find<UserController>().currentUser.value.hotAdNumbers} Left",style: TextStyles.h3.copyWith(color: Colors.black),),))
                      ],),
                      SizedBox(height: Get.height*0.01,),
                      Row(children: [
                        Flexible(child: Get.find<UserController>().currentUser.value.superHotAdNumbers==0?SizedBox():GestureDetector(
                          onTap: (){
                            controller.changePropertyFeatureType(0);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            decoration: BoxDecoration(
                                color: controller.property.featureType==0?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: AutoSizeText("Super Hot",style: TextStyles.h3.copyWith(color: controller.property.featureType==0?Colors.white:Colors.black),),),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Flexible(child: Get.find<UserController>().currentUser.value.hotAdNumbers==0?SizedBox():GestureDetector(
                          onTap: (){
                            controller.changePropertyFeatureType(1);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            decoration: BoxDecoration(
                                color: controller.property.featureType==1?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: AutoSizeText("Hot",style: TextStyles.h3.copyWith(color: controller.property.featureType==1?Colors.white:Colors.black),),),
                          ),
                        ))
                      ],),
                    ],
                  ),
                ),),
            ):SizedBox(),
                SizedBox(height: Get.height*0.01,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: _SelectPropertyTypeSection(),
                ),
                Divider(thickness: 2,),
                _SelectSubPropertyType(),
                Divider(thickness: 2,),
                _BasicPropertyInfo(),
                Divider(thickness: 2,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: _AddFeatures(),
                ),
                Divider(thickness: 2,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                  child: _BasicContactInfo(),
                ),
                Divider(thickness: 2,),
                _UploadPictures()
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _SelectPropertyTypeSection extends GetView<AddPropertyController>{

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText("Property type",style: TextStyles.h3,),
        SizedBox(height: Get.height*0.01,),
        Container(
          height: Get.height*0.1,
          child: Row(
            children: [
              for(Map property in Property.propertyTypes)
                Expanded(child: GestureDetector(
                  onTap: (){
                    controller.changePropertyType(property['name']);
                  },
                  child: Column(
                  children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: controller.property.propertyType==property['name']?Theme.of(context).primaryColor:Colors.white,width: controller.property.propertyType==property['name']?2:0),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      child: Center(child: property["icon"].runtimeType==String?SizedBox(
                          width: Get.height*0.04,
                          height: Get.height*0.04,
                          child: Image.asset(property['icon'],)):Icon(property['icon'],size: 20,color: Colors.black,),),
                    ),
                    ),
                  ),
                    SizedBox(height: Get.height*0.01,),
                    Flexible(child: AutoSizeText(property['name']))
                  ],
                  ),
                ))
            ],
          ),
        )
      ],
    );
  }
}

class _SelectSubPropertyType extends GetView<AddPropertyController> {
  @override
  Widget build(BuildContext context) {
    print(controller.subPropertyType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
          child: AutoSizeText("Property Sub type",style: TextStyles.h3,),
        ),
        SizedBox(height: Get.height*0.01,),
        Container(
          height: Get.height*0.11,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
              itemCount: controller.subPropertyType.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_,index){
            return GestureDetector(
              onTap: (){
                controller.changePropertySubType(controller.subPropertyType[index]['name']);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: controller.property.propertySubType==controller.subPropertyType[index]['name']?Theme.of(context).primaryColor:Colors.white,width: controller.property.propertySubType==controller.subPropertyType[index]['name']?2:0),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.symmetric(horizontal: Get.width*0.03),
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                          child: Center(child: controller.subPropertyType[index]["icon"].runtimeType==String?SizedBox(
                              width: Get.height*0.05,
                              height: Get.height*0.05,
                              child: Image.asset(controller.subPropertyType[index]['icon'],)):Icon(controller.subPropertyType[index]['icon'],size: 20,color: Colors.black,),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*0.01,),
                  AutoSizeText(controller.subPropertyType[index]['name'])
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}


class _BasicPropertyInfo extends GetView<AddPropertyController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Get.height*0.01,),
          AutoSizeText("Basic Property Info",style: TextStyles.h3,textAlign: TextAlign.center,),
          SizedBox(height: Get.height*0.01,),
          AutoSizeText("City",style: TextStyles.h3,textAlign: TextAlign.start,),
          SizedBox(height: Get.height*0.01,),
          TextFormField(
            controller: controller.cityController,
           readOnly: true,
            onTap: ()async{
              var data=await Get.to(()=>SearchCities());
              if(data!=null){
                controller.cityController.text=data;
                controller.property.city=data;
                controller.property.society=null;
                controller.societyController.clear();
                controller.update();
              }
            },
            decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
            ),
            validator: (val){
              if(val!.isEmpty){
                return "City is required";
              }
              return null;
            },
          ),
          SizedBox(height: Get.height*0.01,),
          Row(
            children: [
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Society",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    controller: controller.societyController,
                    readOnly: true,
                    onTap: ()async{
                      if(controller.cityController.text.isEmpty){
                        Show.showErrorSnackBar("Error", "Select a city before selecting society");
                      }
                      else{
                        var data=await Get.to(()=>SearchSociety(controller.cityController.text));
                        if(data!=null){
                          controller.societyController.text=data;
                          controller.property.society=data;
                          controller.update();
                        }
                      }
                    },
                    validator: (val){
                      if(val!.isEmpty){
                        return "Society is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              )),
              SizedBox(width: 10,),
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Phase",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    onSaved: (val){
                      controller.property.phase=val;
                    },
                    initialValue: controller.property.phase,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: Get.height*0.01,),
          Row(
            children: [
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Block",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    onSaved: (val){
                      controller.property.block=val;
                    },
                    initialValue: controller.property.block,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              )),
              SizedBox(width: 10,),
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Sector",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    onSaved: (val){
                      controller.property.sector=val;
                    },
                    initialValue: controller.property.sector,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: Get.height*0.01,),
          Row(
            children: [
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Road",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    onSaved: (val){
                      controller.property.road=val;
                    },
                    initialValue: controller.property.road,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              )),
              SizedBox(width: 10,),
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Street",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    onSaved: (val){
                      controller.property.street=val;
                    },
                    initialValue: controller.property.street,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: Get.height*0.01,),
          AutoSizeText("Property Number",style: TextStyles.h3,textAlign: TextAlign.start,),
          SizedBox(height: Get.height*0.01,),
          Row(children: [ for (Widget one in controller.pairedList)
            Flexible(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: one,
            )),],),
          SizedBox(height: Get.height*0.01,),
          controller.property.propertyType=="Plot"?Row(
            children:[Checkbox(
              activeColor: primaryColor,
            onChanged: (val){
                controller.pair1=val!;
                controller.pair2=false;
                controller.pair3=false;

              if(controller.pairValue==2 && controller.pair1==false){

                controller.pairValue=1;
                controller.pairedList=[
                    TextField(
                      onChanged: (val){
                        controller.propertyNumber1=val;
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
                controller.update();
              }
              else{
                controller.pairValue=2;
                controller.handlePairChange(2);
              }
            },
            value: controller.pair1,
          ),
          AutoSizeText("Pair",presetFontSizes: [16,14],style: TextStyle(color: Colors.teal),),
          Checkbox(
            activeColor: primaryColor,
            onChanged: (val){

              controller.pair2=val!;
              controller.pair3=false;
              controller.pair1=false;

              if(controller.pairValue==3 && controller.pair2==false){

                controller.pairValue=1;
                controller.pairedList=[
                    TextField(
                      onChanged: (val){
                        controller.propertyNumber1=val;
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
                controller.update();
              }
              else{
                  controller.pairValue=3;
                  controller.handlePairChange(3);
              }
            },
            value: controller.pair2,
          ),
          AutoSizeText("Triple",presetFontSizes: [16,14],style: TextStyle(color: Colors.teal)),
          Checkbox(
            activeColor: primaryColor,
            onChanged: (val){
              controller.pair3=val!;
              controller.pair2=false;
              controller.pair1=false;
              if(controller.pairValue==4 && controller.pair3==false){
                controller.pairValue=1;
                controller.pairedList=[
                    TextField(
                      onChanged: (val){
                        controller.propertyNumber1=val;
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
                controller.update();
              }
              else{
                controller.pairValue=4;
                controller.handlePairChange(4);
              }
            },
            value: controller.pair3,
          ),
          AutoSizeText("Tetra",presetFontSizes: [16,14],style: TextStyle(color: Colors.teal)),
        ],):SizedBox(),
          SizedBox(height: Get.height*0.01,),
          Row(
            children: [
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Property Size",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  TextFormField(
                    onSaved: (val){
                      controller.property.propertyArea=val;
                    },
                    onChanged: (val){
                      controller.property.propertyArea=val;
                      controller.getConvertedArea(val.isEmpty?"0":val);
                      controller.update();
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
                    initialValue: controller.property.propertyArea,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                    validator: (String? val){
                      if(val==null){
                        return "Enter area size";
                      }
                      if(val.isEmpty){
                        return "Enter area size";
                      }
                      return null;
                    },
                  ),
                ],
              )),
              SizedBox(width: 10,),
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("",style: TextStyles.h3,textAlign: TextAlign.start,),
                  SizedBox(height: Get.height*0.01,),
                  DropdownButtonFormField(
                    isDense: true,
                    onChanged: (val){
                      controller.property.areaType=val as String;
                      controller.getConvertedArea(controller.property.propertyArea??"0");
                      controller.update();
                    },
                    items: controller.areaTypes.map((e) => DropdownMenuItem(
                      value: e,
                      child: AutoSizeText(e),
                    )).toList(),
                    value: controller.property.areaType,
                    validator: (String? val){
                      if(val==null){
                        return "Select area type";
                      }
                      if(val.isEmpty){
                        return "Select area type";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              ))
            ],
          ),
          controller.convertedAreas.length>0?SizedBox(height: MediaQuery.of(context).size.height*0.02,):SizedBox(),
          controller.convertedAreas.length>0?Wrap(children: [
            for (Map one in controller.convertedAreas)
              Chip(label: AutoSizeText("${one['name']} : ${double.parse(one['value'].toString()).toStringAsFixed(2)}"),)
          ],):SizedBox(),
          SizedBox(height: Get.height*0.01,),
          AutoSizeText("Price(Rs)",style: TextStyles.h3,textAlign: TextAlign.start,),
          SizedBox(height: Get.height*0.01,),
          TextFormField(
            initialValue: controller.property.propertyPrice,
            decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
            ),
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
            validator: (val){
              if(val!.isEmpty){
                return "Price is required";
              }
              return null;
            },

            onChanged: (val){
              controller.property.propertyPrice=val;
              controller.update();
            },
            onSaved: (val){
              controller.property.propertyPrice=val;
            },
          ),
          controller.property.propertyPrice!.length==0?SizedBox():SizedBox(height: Get.height*0.01,),
          controller.property.propertyPrice!.length>0?AutoSizeText(controller.setCustomPrice(controller.property.propertyPrice!).capitalizeFirst!,style: TextStyles.body1.copyWith(fontSize: FontSizes.s20),):SizedBox(),
          SizedBox(height: controller.property.propertyType!="Plot"?Get.height*0.01:0,),
          controller.property.propertyType!="Plot"?Card(
            child: Padding(
              padding: EdgeInsets.all(Get.width*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Floor",style: TextStyles.title1,),
                  SizedBox(height: Get.height*0.01,),
                  Container(
                    height: Get.height*0.11,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_,index){
                          return GestureDetector(
                            onTap: (){
                              if(controller.property.floor==(index+1).toString()){
                                controller.property.floor=null;
                              }
                              else{
                                controller.property.floor=(index+1).toString();
                              }
                              controller.update();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(Get.width*0.05),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.property.floor==(index+1).toString()?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                              ),
                              child: Center(
                                child: AutoSizeText("${index+1}",style: TextStyle(color: controller.property.floor==(index+1).toString()?Colors.white:Colors.black),presetFontSizes: [18,16,14],),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ):SizedBox(),
          SizedBox(height: controller.property.propertyType!="Plot"?Get.height*0.01:0,),
          controller.property.propertyType!="Plot"&&controller.property.propertyType!="Commercial"?Card(
            child: Padding(
              padding: EdgeInsets.all(Get.width*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Bedrooms",style: TextStyles.title1,),
                  SizedBox(height: Get.height*0.01,),
                  Container(
                    height: Get.height*0.11,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_,index){
                          return GestureDetector(
                            onTap: (){
                              if(controller.property.bedrooms==(index+1).toString()){
                                controller.property.bedrooms=null;
                              }
                              else{
                                controller.property.bedrooms=(index+1).toString();
                              }
                              controller.update();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(Get.width*0.05),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.property.bedrooms==(index+1).toString()?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                              ),
                              child: Center(
                                child: AutoSizeText("${index+1}",style: TextStyle(color: controller.property.bedrooms==(index+1).toString()?Colors.white:Colors.black),presetFontSizes: [18,16,14],),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ):SizedBox(),
          SizedBox(height: controller.property.propertyType!="Plot"?Get.height*0.01:0,),
          controller.property.propertyType!="Plot"?Card(
            child: Padding(
              padding: EdgeInsets.all(Get.width*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Bathrooms",style: TextStyles.title1,),
                  SizedBox(height: Get.height*0.01,),
                  Container(
                    height: Get.height*0.11,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_,index){
                          return GestureDetector(
                            onTap: (){
                              if(controller.property.bathrooms==(index+1).toString()){
                                controller.property.bathrooms=null;
                              }
                              else{
                                controller.property.bathrooms=(index+1).toString();
                              }
                              controller.update();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(Get.width*0.05),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.property.bathrooms==(index+1).toString()?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                              ),
                              child: Center(
                                child: AutoSizeText("${index+1}",style: TextStyle(color: controller.property.bathrooms==(index+1).toString()?Colors.white:Colors.black),presetFontSizes: [18,16,14],),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ):SizedBox(),
          SizedBox(height: Get.height*0.01,),
          controller.property.purpose==0?AutoSizeText("Property Status",style: TextStyles.h3,textAlign: TextAlign.start,):SizedBox(),
          SizedBox(height: controller.property.purpose==0?Get.height*0.01:0,),
          controller.property.purpose==0?Column(children: [
            controller.property.status?.length==0?TextField(
              readOnly: true,
              onTap: ()async{
                FocusScope.of(context).requestFocus(FocusNode());
                var data=await Get.to(()=>PropertyStatusView(controller.property.propertyType!));
                print(data);
                if(data!=null){
                  controller.property.status=data as List<String>;
                }
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
              ),
            ):Wrap(
              children: [
                GestureDetector(
                  onTap: ()async{
                    FocusScope.of(context).requestFocus(FocusNode());
                    var data=await Get.to(()=>PropertyStatusView(controller.property.propertyType!,selectedStatus: controller.property.status,));
                    print(data);
                    if(data!=null){
                      controller.property.status=data as List<String>;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Chip(label: AutoSizeText("Add More",style: TextStyle(color: Colors.white),),backgroundColor: Theme.of(context).primaryColor,),
                  ),
                ),
                for (String feature in controller.property.status!)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Chip(label: AutoSizeText(feature),onDeleted: (){
                      controller.property.status!.remove(feature);
                      controller.update();
                    },),
                  )
              ],),
          ],):SizedBox(),
          SizedBox(height: Get.height*0.01,),
          AutoSizeText("Property Title",style: TextStyles.h3,textAlign: TextAlign.start,),
          SizedBox(height: Get.height*0.01,),
          TextFormField(
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLength: 100,
            maxLines: null,
            onSaved: (val){
              controller.property.propertyTitle=val;
            },
            initialValue: controller.property.propertyTitle,
            decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
            ),
          ),
          SizedBox(height: Get.height*0.01,),
          AutoSizeText("Property Description",style: TextStyles.h3,textAlign: TextAlign.start,),
          SizedBox(height: Get.height*0.01,),
          TextFormField(
            maxLines: null,
            onSaved: (val){
              controller.property.description=val;
            },
            initialValue: controller.property.description,
            decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
            ),
          ),
        ],
      ),
    );
  }
}


class _BasicContactInfo extends GetView<AddPropertyController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Basic Contact Info",style: TextStyles.h3,textAlign: TextAlign.center,),
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Name",style: TextStyles.h3,textAlign: TextAlign.start,),
        SizedBox(height: Get.height*0.01,),
        TextFormField(
          initialValue: Get.find<UserController>().currentUser.value.name,
          decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
          ),
          validator: (val){
            if(val!.isEmpty){
              return "Name is required";
            }
            return null;
          },
        ),
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Email",style: TextStyles.h3,textAlign: TextAlign.start,),
        SizedBox(height: Get.height*0.01,),
        TextFormField(
          initialValue: Get.find<UserController>().currentUser.value.email,
          decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
          ),
          validator: (val){
            if(val!.isEmpty){
              return "Email is required";
            }
            return null;
          },
        ),
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Estate Name",style: TextStyles.h3,textAlign: TextAlign.start,),
        SizedBox(height: Get.height*0.01,),
        TextFormField(
          initialValue: Get.find<UserController>().currentUser.value.estateName,
          decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
          ),
          validator: (val){
            if(val!.isEmpty){
              return "Estate Name is required";
            }
            return null;
          },
        ),
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Phone Number",style: TextStyles.h3,textAlign: TextAlign.start,),
        SizedBox(height: Get.height*0.01,),
        TextFormField(
          onChanged: (val){
            controller.property.sellerNumber=val;
          },
          initialValue: Get.find<UserController>().currentUser.value.phoneNumber??controller.property.sellerNumber,
          decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
          ),
          validator: (val){
            if(val!.isEmpty){
              return "Phone Number is required";
            }
            return null;
          },
        ),
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Optional Phone Number",style: TextStyles.h3,textAlign: TextAlign.start,),
        SizedBox(height: Get.height*0.01,),
        TextFormField(
          onChanged: (val){
            print(val);
            controller.property.optionalNumber=val;
          },
          initialValue: controller.property.optionalNumber,
          decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
          ),
        ),
        SizedBox(height: Get.height*0.01,),
      ],
    );
  }
}


class _AddFeatures extends GetView<AddPropertyController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Add Features",style: TextStyles.h3,textAlign: TextAlign.center,),
        SizedBox(height: Get.height*0.01,),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Gas"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Gas");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Gas");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Gas",style: TextStyles.body2,))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("TV Lounge"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("TV Lounge");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("TV Lounge");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("TV Lounge",style: TextStyles.body2,))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Kitchen"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Kitchen");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Kitchen");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Kitchen",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Electricity"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Electricity");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Electricity");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Electricity",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Near Market"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Near Market");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Near Market");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Near Market",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Laundry Room"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Laundry Room");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Laundry Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Laundry Room",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Corner"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Corner");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Corner");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Corner",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Store Room"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Store Room");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Store Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Store Room",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Pool"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Pool");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Pool");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Pool",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Near Masjid"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Near Masjid");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Near Masjid");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Near Masjid",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Dining Room"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Dining Room");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Dining Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Dining Room",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Balcony"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Balcony");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Balcony");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Balcony",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Lawn"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Lawn");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Lawn");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Lawn",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Drawing Room"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Drawing Room");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Drawing Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Drawing Room",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.property.propertyFeatures!.contains("Near Park"), onChanged: (val){
              if(val!){
                controller.property.propertyFeatures!.add("Near Park");
                controller.update();
              }
              else{
                controller.property.propertyFeatures!.remove("Near Park");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Near Park",style: TextStyles.body2,))],))
          ],
        ),
        Row(children: [Expanded(child: Row(children: [Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: controller.property.propertyFeatures!.contains("Near School"), onChanged: (val){
          if(val!){
            controller.property.propertyFeatures!.add("Near School");
            controller.update();
          }
          else{
            controller.property.propertyFeatures!.remove("Near School");
            controller.update();
          }
        }),Flexible( child: AutoSizeText("Near School",style: TextStyles.body2,))],)),
        Expanded(child: SizedBox(),),Expanded(child: SizedBox(),)],)
      ],
    );
  }
}

class _UploadPictures extends GetView<AddPropertyController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height*0.01,),
        AutoSizeText("Upload Media",style: TextStyles.h3,textAlign: TextAlign.center,),
        SizedBox(height: Get.height*0.01,),
        Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
              scrollDirection: Axis.horizontal,
              itemCount: controller.property.propertyImages!.length+1+(controller.videoThumbnail!=null|| controller.property.propertyVideoThumbnail!=null?1:0),
              itemBuilder: (BuildContext context,int index){
                if(index == 0){
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        controller.showBottomPopup();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt,color: Colors.grey,),
                          AutoSizeText("Add photos\n/Video",style: TextStyle(color: Colors.grey),maxLines: 2,textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  );
                }
                if((controller.videoThumbnail!=null || controller.property.propertyVideoThumbnail!=null) && index==1){
                  return Stack(children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: controller.videoThumbnail!=null?Image.memory(controller.videoThumbnail!,fit: BoxFit.cover,):CachedNetworkImage(imageUrl: controller.property.propertyVideoThumbnail!,),
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width*0.2,
                    ),
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
                    Positioned(
                        right:0,
                        child: GestureDetector(
                          onTap:(){
                            controller.videoThumbnail=null;
                            controller.property.propertyVideo=null;
                            controller.property.localPropertyThumbnail=null;
                            controller.property.propertyVideoThumbnail=null;
                            controller.update();
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                            child: Icon(Icons.close,color: Colors.black,),
                          ),
                        ))
                  ],);
                }
                return Stack(children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: controller.property.propertyImages![controller.videoThumbnail!=null|| controller.property.propertyVideoThumbnail!=null?index-2:index-1].contains("firebasestorage")?CachedNetworkImage(imageUrl: controller.property.propertyImages![controller.videoThumbnail!=null|| controller.property.propertyVideoThumbnail!=null?index-2:index-1],fit: BoxFit.cover,):Image.file(File(controller.property.propertyImages![controller.videoThumbnail!=null|| controller.property.propertyVideoThumbnail!=null?index-2:index-1]),fit: BoxFit.cover,),
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.2,
                  ),
                  Positioned(
                      right:0,
                      child: GestureDetector(
                        onTap:(){
                          controller.property.propertyImages!.remove(controller.property.propertyImages![controller.videoThumbnail!=null|| controller.property.propertyVideoThumbnail!=null?index-2:index-1]);
                          controller.update();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                          child: Icon(Icons.close,color: Colors.black,),
                        ),
                      ))
                ],);
              }),
        ),
        SizedBox(height: Get.height*0.02,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
          child: RippleButton(
            width: Get.width*1,
            borderRadius: BorderRadius.circular(10),
            onPressed: (){
              if(controller.formKey.currentState!.validate()){
                controller.formKey.currentState!.save();
                if(controller.property.propertySubType==null){
                  Show.showErrorSnackBar("Error", "Select property type to continue");
                  return;
                }
                  controller.uploadProperty();
              }
            },title:controller.edit?"Update":"Done",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
        ),
        SizedBox(height: Get.height*0.02,),
      ],
    );
  }
}
