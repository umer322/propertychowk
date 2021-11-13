import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/filter/filter_controller.dart';
import 'package:propertychowk/ui/views/tabs/tabs_controller.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/ui/widgets/search_cities.dart';
import 'package:propertychowk/ui/widgets/search_society.dart';
import 'package:propertychowk/utils/colors.dart';
import 'package:propertychowk/utils/show.dart';
import 'package:propertychowk/utils/styles.dart';


class FilterOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_outlined),onPressed: (){
            Get.back();
            Get.find<TabsController>().changeTab(0);
        },),
          backgroundColor: Color(0xfff5f6fa),
        elevation: 0.0,
      centerTitle: true,
      title: Image.asset(
        "assets/display.png",
        width: Get.width * 0.4,
        height: Get.width * 0.4,
      ),


        ),
      backgroundColor: Color(0xfff5f6fa),
      body: GetBuilder<FilterController>(builder: (controller){
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      SizedBox(width: 10,),
                      AutoSizeText("    Filters",style: TextStyles.h2,),
                    ],
                  ),
                  Container(width: Get.width*0.1)
                  ],
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
                            controller.changePropertyFilterPurpose(0);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            padding: EdgeInsets.symmetric(horizontal: Get.width*0.06,vertical: 10),
                            decoration: BoxDecoration(
                                color: controller.filter.purpose==0?Theme.of(context).primaryColor:Colors.white,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Center(child: AutoSizeText("Buy",style: TextStyles.h3.copyWith(color: controller.filter.purpose==0?Colors.white:Colors.black),),),
                          ),
                        )),
                        Flexible(child: GestureDetector(
                          onTap: (){
                            controller.changePropertyFilterPurpose(1);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            padding: EdgeInsets.symmetric(horizontal: Get.width*0.06,vertical: 10),
                            decoration: BoxDecoration(
                                color: controller.filter.purpose==1?Theme.of(context).primaryColor:Colors.white,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Center(child: AutoSizeText("Rent",style: TextStyles.h3.copyWith(color: controller.filter.purpose==1?Colors.white:Colors.black),),),
                          ),
                        )),
                        // Flexible(child: GestureDetector(
                        //   onTap: (){
                        //     controller.changePropertyFilterPurpose(2);
                        //   },
                        //   child: AnimatedContainer(
                        //     duration: Duration(milliseconds: 700),
                        //     padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: 10),
                        //     decoration: BoxDecoration(
                        //         color: controller.filter.purpose==2?Theme.of(context).primaryColor:Colors.white,
                        //         borderRadius: BorderRadius.circular(25)
                        //     ),
                        //     child: Center(child: AutoSizeText("Requirement",style: TextStyles.h3.copyWith(color: controller.filter.purpose==2?Colors.white:Colors.black),),),
                        //   ),
                        // ))
                      ],),
                  )
                ],),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.01,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                        child: AutoSizeText("Property type",style: TextStyles.h3,),
                      ),
                      SizedBox(height: Get.height*0.01,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*0.01),
                        child: Container(
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
                                              border: Border.all(color: controller.filter.propertyType==property['name']?Theme.of(context).primaryColor:Colors.white,width: controller.filter.propertyType==property['name']?2:0),
                                              borderRadius: BorderRadius.circular(10),
                                            color: Color(0xfff5f6fa),
                                          ),
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          child: Material(
                                            color:Color(0xfff5f6fa),
                                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                                            child: Center(child: property["icon"].runtimeType==String?SizedBox(
                                                width: Get.height*0.04,
                                                height: Get.height*0.04,
                                                child: Image.asset(property['icon'],)):Icon(property['icon'],size: 20,color: Colors.black,),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      Flexible(child: AutoSizeText(property['name'],))
                                    ],
                                  ),
                                ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height*0.01,),
                      Divider(thickness: 2,),
                      SizedBox(height: Get.height*0.01,),
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
                                            border: Border.all(color: controller.filter.propertySubType==controller.subPropertyType[index]['name']?Theme.of(context).primaryColor:Colors.white,width: controller.filter.propertySubType==controller.subPropertyType[index]['name']?2:0),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: Get.width*0.04),
                                        child: Material(
                                          color: Color(0xfff5f6fa),
                                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                                            child: Center(child: controller.subPropertyType[index]["icon"].runtimeType==String?SizedBox(
                                                width: Get.height*0.04,
                                                height: Get.height*0.04,
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
                      ),
                      SizedBox(height: Get.height*0.01,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(Get.width*0.03),
                    child: Column(
                      children: [
                        Row(children: [
                          AutoSizeText("Price Range",style: TextStyles.title1,)
                        ],),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Row(
                          children: [
                            Expanded(child: TextField(
                              controller: controller.minPrice,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              onChanged: (val){
                                  controller.update();
                              },
                              decoration: InputDecoration(
                                   hintText: "0",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: AutoSizeText("TO",presetFontSizes: [16,14],),
                            ),
                            Expanded(child: TextField(
                              controller: controller.maxPrice,
                              onChanged: (val){
                                controller.update();
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                  hintText:"Any",
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                              ),
                            ))
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Row(
                          children: [
                            Expanded(child: controller.minPrice.text.length>0?AutoSizeText(controller.setCustomPrice(controller.minPrice.text).capitalizeFirst!,style: TextStyles.body1.copyWith(fontSize: FontSizes.s14),):SizedBox(),
                            ),
                            controller.minPrice.text.length>0||controller.maxPrice.text.length>0?Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: AutoSizeText(" ",presetFontSizes: [16,14],),
                            ):SizedBox(),
                            Expanded(child: controller.maxPrice.text.length>0?AutoSizeText(controller.setCustomPrice(controller.maxPrice.text).capitalizeFirst!,style: TextStyles.body1.copyWith(fontSize: FontSizes.s14),):SizedBox(),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(Get.width*0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Property Size",style: TextStyles.title1,),
                        SizedBox(height: Get.height*0.01,),
                        Row(children: [
                          Flexible(child: TextFormField(
                            onChanged: (val){
                              controller.filter.area=val;
                              controller.getConvertedArea(val.isEmpty?"0":val);
                              controller.update();
                            },
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
                            controller: controller.area,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10))
                            ),
                          ),),
                          SizedBox(width: 10,),
                          Flexible(child: DropdownButtonFormField(
                            isDense: true,
                            onChanged: (val){
                              controller.filter.areaType=val as String;
                              controller.getConvertedArea(controller.filter.area??"0");
                              controller.update();
                            },
                            items: controller.areaTypes.map((e) => DropdownMenuItem(
                              value: e,
                              child: AutoSizeText(e),
                            )).toList(),
                            value: controller.filter.areaType,
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
                          ),)
                        ],),
                        controller.convertedAreas.length>0?SizedBox(height: MediaQuery.of(context).size.height*0.02,):SizedBox(),
                        controller.convertedAreas.length>0?Wrap(children: [
                          for (Map one in controller.convertedAreas)
                            Chip(label: AutoSizeText("${one['name']} : ${double.parse(one['value'].toString()).toStringAsFixed(2)}"),)
                        ],):SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: AutoSizeText("City",style: TextStyles.h3,textAlign: TextAlign.start,),
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: TextField(
                  controller: controller.cityController,
                  readOnly: true,
                  onTap: ()async{
                    var data=await Get.to(()=>SearchCities());
                    if(data!=null){
                      controller.cityController.text=data;
                      controller.filter.city=data;
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
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Row(
                  children: [
                    Flexible(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Society",style: TextStyles.h3,textAlign: TextAlign.start,),
                        SizedBox(height: Get.height*0.01,),
                        TextField(
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
                                controller.filter.society=data;
                                controller.update();
                              }
                            }
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
                          onChanged: (val){
                            controller.filter.phase=val;
                          },
                         controller: controller.phase,
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
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Row(
                  children: [
                    Flexible(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Block",style: TextStyles.h3,textAlign: TextAlign.start,),
                        SizedBox(height: Get.height*0.01,),
                        TextFormField(
                          onChanged: (val){
                            controller.filter.block=val;
                          },
                          controller:controller.block,
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
                          onChanged: (val){
                            controller.filter.sector=val;
                          },
                          controller: controller.sector,
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
              ),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Row(
                  children: [
                    Flexible(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Road",style: TextStyles.h3,textAlign: TextAlign.start,),
                        SizedBox(height: Get.height*0.01,),
                        TextFormField(
                          onChanged: (val){
                            controller.filter.road=val;
                          },
                          controller: controller.road,
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
                          onChanged: (val){
                            controller.filter.street=val;
                          },
                          controller: controller.street,
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
              ),
              controller.filter.propertyType=="Plot"||controller.filter.propertyType=="Commercial"?SizedBox():SizedBox(height: Get.height*0.01,),
              controller.filter.propertyType=="Plot"||controller.filter.propertyType=="Commercial"?SizedBox():Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Card(
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
                                    if(controller.filter.bedrooms==(index+1).toString()){
                                      controller.filter.bedrooms=null;
                                    }
                                    else{
                                      controller.filter.bedrooms=(index+1).toString();
                                    }
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(Get.width*0.05),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.filter.bedrooms==(index+1).toString()?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                                    ),
                                    child: Center(
                                      child: AutoSizeText("${index+1}",style: TextStyle(color: controller.filter.bedrooms==(index+1).toString()?Colors.white:Colors.black),presetFontSizes: [18,16,14],),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              //

           //   controller.filter.propertyType=="Plot"||controller.filter.propertyType=="Commercial"?SizedBox():SizedBox(height: Get.height*0.01,),
              controller.filter.propertyType=="Plot"?SizedBox():Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Card(
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
                                    if(controller.filter.floor==(index+1).toString()){
                                      controller.filter.floor=null;
                                    }
                                    else{
                                      controller.filter.floor=(index+1).toString();
                                    }
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(Get.width*0.05),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.filter.floor==(index+1).toString()?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                                    ),
                                    child: Center(
                                      child: AutoSizeText("${index+1}",style: TextStyle(color: controller.filter.floor==(index+1).toString()?Colors.white:Colors.black),presetFontSizes: [18,16,14],),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),




              SizedBox(height: Get.height*0.01,),
              controller.filter.propertyType=="Plot"?SizedBox():Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: Card(
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
                                    if(controller.filter.bathrooms==(index+1).toString()){
                                      controller.filter.bathrooms= null;
                                    }
                                    else{
                                      controller.filter.bathrooms=(index+1).toString();
                                    }
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(Get.width*0.05),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.filter.bathrooms==(index+1).toString()?Theme.of(context).primaryColor:Color(0xfff5f6fa),
                                    ),
                                    child: Center(
                                      child: AutoSizeText("${index+1}",style: TextStyle(color: controller.filter.bathrooms==(index+1).toString()?Colors.white:Colors.black),presetFontSizes: [18,16,14],),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              _AddFeatures(),
              SizedBox(height: Get.height*0.01,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                child: RippleButton(
                  width: Get.width*1,
                  borderRadius: BorderRadius.circular(35),
                  onPressed: (){
                      Get.back();
                      controller.sortProperties();
                  },title: "Search",backGroundColor: Theme.of(context).primaryColor,fontSize: FontSizes.s18,splashColor: Colors.white,elevation: 10,),
              ),
              SizedBox(height: Get.height*0.02,),
            ],
          ),
        );
      },),
    );
  }
}


class _AddFeatures extends GetView<FilterController> {
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
                value: controller.filter.features!.contains("Gas"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Gas");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Gas");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Gas",style: TextStyles.body2,))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("TV Lounge"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("TV Lounge");
                controller.update();
              }
              else{
                controller.filter.features!.remove("TV Lounge");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("TV Lounge",style: TextStyles.body2,))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Kitchen"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Kitchen");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Kitchen");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Kitchen",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Electricity"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Electricity");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Electricity");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Electricity",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Near Market"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Near Market");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Near Market");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Near Market",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Laundry Room"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Laundry Room");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Laundry Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Laundry Room",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Corner"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Corner");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Corner");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Corner",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Store Room"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Store Room");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Store Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Store Room",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Pool"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Pool");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Pool");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Pool",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Near Masjid"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Near Masjid");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Near Masjid");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Near Masjid",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Dining Room"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Dining Room");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Dining Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Dining Room",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Balcony"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Balcony");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Balcony");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Balcony",style: TextStyles.body2,))],))
          ],
        ),
        Row(
          children: [
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Lawn"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Lawn");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Lawn");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Lawn",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Drawing Room"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Drawing Room");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Drawing Room");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Drawing Room",style: TextStyles.body2))],)),
            Expanded(child: Row(children: [Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.filter.features!.contains("Near Park"), onChanged: (val){
              if(val!){
                controller.filter.features!.add("Near Park");
                controller.update();
              }
              else{
                controller.filter.features!.remove("Near Park");
                controller.update();
              }
            }),Flexible( child: AutoSizeText("Near Park",style: TextStyles.body2,))],))
          ],
        ),
        Row(children: [Expanded(child: Row(children: [Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: controller.filter.features!.contains("Near School"), onChanged: (val){
          if(val!){
            controller.filter.features!.add("Near School");
            controller.update();
          }
          else{
            controller.filter.features!.remove("Near School");
            controller.update();
          }
        }),Flexible( child: AutoSizeText("Near School",style: TextStyles.body2,))],)),
          Expanded(child: Row(children: [Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: controller.filter.features!.contains("Pair"), onChanged: (val){
            if(val!){
              controller.filter.features!.add("Pair");
              controller.update();
            }
            else{
              controller.filter.features!.remove("Pair");
              controller.update();
            }
          }),Flexible( child: AutoSizeText("Pair",style: TextStyles.body2,))],)),
          Expanded(child: Row(children: [Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: controller.filter.features!.contains("Triple"), onChanged: (val){
            if(val!){
              controller.filter.features!.add("Triple");
              controller.update();
            }
            else{
              controller.filter.features!.remove("Triple");
              controller.update();
            }
          }),Flexible( child: AutoSizeText("Triple",style: TextStyles.body2,))],),)],),
        Row(children: [
          Expanded(child: Row(children: [Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: controller.filter.features!.contains("Tetra"), onChanged: (val){
            if(val!){
              controller.filter.features!.add("Tetra");
              controller.update();
            }
            else{
              controller.filter.features!.remove("Tetra");
              controller.update();
            }
          }),Flexible( child: AutoSizeText("Tetra",style: TextStyles.body2,))],)),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox())
        ],)
      ],
    );
  }
}