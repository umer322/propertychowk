import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/localstorage_service.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/addproperty/addproperty_controller.dart';
import 'package:propertychowk/ui/views/addproperty/addproperty_view.dart';
import 'package:propertychowk/ui/views/propertydetail/propertydetail_controller.dart';
import 'package:propertychowk/ui/widgets/appprogress_indicatior.dart';
import 'package:propertychowk/ui/widgets/gallery_view.dart';
import 'package:propertychowk/ui/widgets/ripple_button.dart';
import 'package:propertychowk/utils/show.dart';
import 'package:propertychowk/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class PropertyDetailView extends StatelessWidget {
  final Property property;
  PropertyDetailView(this.property);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: GetBuilder<PropertyDetailController>(
        init: PropertyDetailController(property),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: kToolbarHeight,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                      AutoSizeText(
                        "Property Detail",
                        style: TextStyles.h2,
                      ),
                      Get.find<UserController>().currentUser.value.id !=
                          property.sellerId
                          ? Flexible(
                        child: Obx((){
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            IconButton(icon: Icon(Get.find<UserController>().currentUser.value.favorites!.contains(property.id!)?Icons.favorite:Icons.favorite_border),
                              onPressed: (){
                                Get.find<UserController>().addFavoriteProperty(property.id!);
                              },
                              color: Theme.of(context).primaryColor,
                            ),
                              IconButton(icon: Icon(Icons.share),
                                onPressed: ()async{
                                Show.showLoader();
                                 // String url=await  Get.find<LocalStorageService>().createPropertyLink(property.id!);
                                 // if(Get.isOverlaysOpen){
                                 //   Get.back();
                                 // }
                                 // Share.share(url);
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                          ],);
                        }),
                      )
                          : SizedBox(width: Get.width*0.05,)
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.01,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.25,
                        width: Get.width,
                        child: controller.images.length == 0
                            ? Image.asset(property.propertyType == "Plot"
                                ?"assets/plot2.png":"assets/background2.png")
                            : GestureDetector(
                          onTap: (){
                            if(controller.property.propertyImages!.length>0){
                              Get.to(()=>GalleryView(images: controller.property.propertyImages!));
                            }
                          },
                              child: CarouselSlider(
                                  items: controller.images,
                                  carouselController:
                                      controller.carouselController,
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        controller.index = index;
                                        controller.update();
                                      }),
                                ),
                            ),
                      ),
                      controller.images.length != 0
                          ? Image.asset(
                              "assets/flag.png",
                              width: Get.width * 0.3,
                              height: Get.height * 0.3,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.005,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => controller.carouselController
                          .animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(
                                    controller.index == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10,
                      left: Get.width * 0.05,
                      right: Get.width * 0.05),
                  child: Align(
                    child: AutoSizeText(
                      "${property.propertyArea} ${property.areaType} ${property.propertyType == "Home" || property.propertyType == "Commercial" ? property.propertySubType : "${property.propertySubType} ${property.propertyType}"} For ${property.purpose == 0 ? "Sale" : "Rent"}",
                      style: TextStyles.h2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    child: AutoSizeText(
                      "${property.society} ${property.phase!.isNotEmpty ? property.phase : ""},${property.city}",
                      style: TextStyles.body2,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    child: AutoSizeText.rich(TextSpan(
                        children: [
                          TextSpan(
                              text: "PKR ",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(
                              text:
                                  Property.buildPrice(property.propertyPrice!),
                              style: TextStyle(fontWeight: FontWeight.w700))
                        ],
                        style: TextStyles.h2
                            .copyWith(color: Theme.of(context).primaryColor))),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _BasicPropertyInfo(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.01,
                ),
              ),
              SliverToBoxAdapter(
                child: controller.property.propertyTitle!=null?controller.property.propertyTitle!.isEmpty?SizedBox():_PropertyTitle():SizedBox(),
              ),
              SliverToBoxAdapter(
                child: controller.property.description!=null?controller.property.description!.isEmpty?SizedBox():_PropertyDescription():SizedBox(),
              ),
              SliverToBoxAdapter(
                child: _KeyFeatures(),
              ),
              SliverToBoxAdapter(
                child: controller.property.status!.length>0?Padding(
                  padding: EdgeInsets.only(top:  Get.height * 0.01),
                  child: _StatusView(),
                ):SizedBox(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.01,
                ),
              ),
              SliverToBoxAdapter(
                child: _AgentDetail(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.01,
                ),
              ),
              SliverToBoxAdapter(
                child: controller.seller == null
                    ? Center(
                        child: AppProgressIndication(),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                        child: Get.find<UserController>()
                                    .currentUser
                                    .value
                                    .id ==
                                controller.seller!.id
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.2),
                                child: RippleButton(
                                  width: Get.width * 1,
                                  borderRadius: BorderRadius.circular(35),
                                  onPressed: () {
                                    Get.to(() => AddPropertyView(),
                                        binding: BindingsBuilder(() {
                                      Get.put(AddPropertyController(
                                          controller.property));
                                    }));
                                  },
                                  title: "Edit",
                                  backGroundColor:
                                      Theme.of(context).primaryColor,
                                  fontSize: FontSizes.s18,
                                  splashColor: Colors.white,
                                  elevation: 10,
                                ),
                              )
                            : Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      controller.launchURL(
                                          "mailto:${controller.seller!.email}?subject=Related to Property Chowk App&body=to discuss about property for sale");
                                    },
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    label: AutoSizeText(
                                      "Email",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context).primaryColor),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),

                                  // Expanded(
                                  //     flex: 2,
                                  //     child: ElevatedButton.icon(onPressed: (){
                                  //       controller.launchURL("tel:${controller.seller!.phoneNumber}");
                                  //     }, icon: Icon(Icons.phone,color: Colors.white,), label: Shimmer.fromColors(
                                  //         baseColor: Colors.green,
                                  //         highlightColor: Colors.grey,
                                  //         child: AutoSizeText("Call",style: TextStyle(color: Colors.white),)),style: ButtonStyle(
                                  //         backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                  //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                                  //     ),)),

                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 35,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            controller.launchURL(
                                                "tel:${controller.seller!.phoneNumber}");
                                          },
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.white,
                                              highlightColor:
                                                  Colors.grey.shade600,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                  AutoSizeText("Call")
                                                ],
                                              ))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          controller.launchURL(
                                              "whatsapp://send?phone=${controller.seller!.phoneNumber}");
                                        },
                                        icon:
                                            Image.asset("assets/whatsapp.png"),
                                        label: AutoSizeText(
                                          "Whatsapp",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green[600]),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                      ))
                                ],
                              ),
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _BasicPropertyInfo extends GetView<PropertyDetailController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Container(
        width: Get.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

    AutoSizeText("Basic Property Info",style: TextStyles.h2.copyWith(color: Theme.of(context).primaryColor),textAlign: TextAlign.center,),
    Center(
    child: SizedBox(
    width: Get.width*0.3,
    child: Divider(
    thickness: 2,
    ))),
            controller.property.block == null
                ? SizedBox()
                : controller.property.block!.isEmpty?SizedBox():controller.addCard(
                title: "Block",
                value: "${controller.property.block!.toUpperCase()}",),
            controller.property.phase == null
                ? SizedBox()
                : controller.property.phase!.isEmpty?SizedBox():controller.addCard(
              title: "Phase",
              value: "${controller.property.phase!.toUpperCase()}",),
            controller.property.society == null
                ? SizedBox()
                : controller.property.society!.isEmpty?SizedBox():controller.addCard(
              title: "Society",
              value: "${controller.property.society!.toUpperCase()}",),
            controller.addCard(
                title: "City",
                value: "${controller.property.city}",),
            controller.addCard(
                title: "Area",
                value:
                    "${controller.property.propertyArea} ${controller.property.areaType}"),
            controller.property.floor == null
                ? SizedBox()
                : controller.addCard(
                    title: "Floor",
                    value: "${controller.property.floor}",),
            controller.property.propertyType == "Plot" ||
                    controller.property.propertyType == "Commercial"
                ? SizedBox()
                : controller.addCard(
                    title: "Bedrooms",
                    value: controller.property.bedrooms,),
            controller.property.propertyType == "Plot" ||
                    controller.property.propertyType == "Commercial"
                ? SizedBox()
                : SizedBox(),
            controller.property.propertyType == "Plot"
                ? SizedBox()
                : controller.addCard(
                    title: "Bathrooms",
                    value: "${controller.property.bathrooms ?? 0}"),
            controller.addCard(
                title: "Property Type",
                value: "${controller.property.propertySubType}",),
            controller.property.propertyNumber == null
                ? SizedBox()
                : controller.addCard(
                    title: "Property Number",
                    value: "${controller.property.propertyNumber!}",),
            controller.property.description != null
                ? controller.property.description!.length == 0
                    ? SizedBox()
                    : SizedBox()
                : SizedBox(),
            controller.addCard(title: "Full Address",value: "${controller.property.street!.isNotEmpty?controller.property.street!.contains("treet")?
    controller.property.street!:"Street ${controller.property.street!}"+", ":""}${controller.property.road!.isNotEmpty?controller.property.road!.
    contains("oad")?controller.property.road:"Road ${controller.property.road!}"+", ":""}${controller.property.block!.isNotEmpty?controller.property.block!.contains("lock")?controller.property.block!.toUpperCase()+", ":"Block ${controller.property.block!.toUpperCase()}"+", ":""}${controller.property.phase!.isNotEmpty?controller.property.phase!.contains("hase")?controller.property.phase!+", ":"Phase ${controller.property.phase}"+", ":""} ${controller.property.sector!.isNotEmpty?
    controller.property.sector!.contains("ector")?controller.property.sector!+", ":"Sector${controller.property.sector}"+", ":""} ${controller.property.society!.isNotEmpty?controller.property.society!+", ":""}${controller.property.city}")




          ],
        ),
      ),
    );
  }
}
/*
class _BasicPropertyInfo extends GetView<PropertyDetailController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Get.width*0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AutoSizeText("Basic Property Info",style: TextStyles.h2.copyWith(color: Theme.of(context).primaryColor),textAlign: TextAlign.center,),
              Center(
                child: SizedBox(
                  width: Get.width*0.3,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.01,),





              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(


                        children: [
                          Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor,),
                          AutoSizeText.rich(

                              TextSpan(
                              children: [
                                TextSpan(
                                    text: "City: ",
                                    style: TextStyle(color: Colors.black54)
                                ),
                                TextSpan(
                                    text: "${controller.property.city}",
                                    style: TextStyle(color: Colors.black)
                                )
                              ],
                              style: TextStyles.title1
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),
                          AutoSizeText.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: "Area: ",
                                    style: TextStyle(color: Colors.black54)
                                ),
                                TextSpan(
                                    text: "${controller.property.propertyArea} ${controller.property.areaType}",
                                    style: TextStyle(color: Colors.black)
                                )
                              ],
                              style: TextStyles.title1
                          )),
                        ],
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                    controller.property.floor==null?SizedBox():Row(
                      children: [
                        Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),
                        AutoSizeText.rich(TextSpan(
                            children: [
                              TextSpan(
                                  text: "Floor: ",
                                  style: TextStyle(color: Colors.black54)
                              ),
                              TextSpan(
                                  text: "${controller.property.floor}",
                                  style: TextStyle(color: Colors.black)
                              )
                            ],
                            style: TextStyles.title1
                        )),
                      ],
                    ),
                    Row(

                      children: [

                        controller.property.propertyType=="Plot"||controller.property.propertyType=="Commercial"?SizedBox():Row(
                          children: [
                            Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),
                            AutoSizeText.rich(TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Bedrooms: ",
                                      style: TextStyle(color: Colors.black54)
                                  ),
                                  TextSpan(
                                      text: "${controller.property.bedrooms??0}",
                                      style: TextStyle(color: Colors.black)
                                  )
                                ],
                                style: TextStyles.title1
                            )),
                          ],
                        ),

                      ],
                    ),
                  ],),


                ],
              ),
Row(children: [

  Column(


    children: [

    controller.property.propertyType=="Plot"||controller.property.propertyType=="Commercial"?SizedBox():SizedBox(),
    controller.property.propertyType=="Plot"?SizedBox():Row(
      children: [

        Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),

        AutoSizeText.rich(TextSpan(
            children: [
              TextSpan(
                  text: "Bathrooms: ",
                  style: TextStyle(color: Colors.black54)
              ),
              TextSpan(
                  text: "${controller.property.bathrooms??0}",
                  style: TextStyle(color: Colors.black)
              )
            ],
            style: TextStyles.title1
        )),
      ],
    ),


  ],)

],),
Row(children: [

  Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),


  AutoSizeText.rich(TextSpan(
      children: [
        TextSpan(
            text: "Property Type: ",
            style: TextStyle(color: Colors.black54)
        ),
        TextSpan(
            text: "${controller.property.propertySubType}",
            style: TextStyle(color: Colors.black)
        )
      ],
      style: TextStyles.title1
  )),


],),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),

                Text("Full Address: ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
                Flexible(
                  child: Container(
                    height: 20,
                    width: Get.width*0.5,
                    child: AutoSizeText.rich(

                        TextSpan(

                        children: [

                          TextSpan(

                              text: "${controller.property.street!.isNotEmpty?controller.property.street!.contains("treet")?
                              controller.property.street!:"Street ${controller.property.street!}"+",":""}
                              ${controller.property.road!.isNotEmpty?controller.property.road!.
                              contains("oad")?controller.property.road:"Road ${controller.property.road!}"+",":""}
                              ${controller.property.block!.isNotEmpty?controller.property.block!.contains("lock")?controller.property.block!+",":"Block
                              ${controller.property.block}"+",":""}
                              ${controller.property.phase!.isNotEmpty?controller.property.phase!.contains("hase")?controller.property.phase!+",
                              ":"Phase ${controller.property.phase}"+",":""} ${controller.property.sector!.isNotEmpty?
                              controller.property.sector!.contains("ector")?controller.property.sector!+",":"Sector
                              ${controller.property.sector}"+",":""} ${controller.property.society!.isNotEmpty?controller.property.society!+",":""}
                              ${controller.property.city}",
                              style: TextStyle(color: Colors.black,)
                          )
                        ],
                        style: TextStyles.title1
                    ),



                    ),
                  ),
                ),

              ],),



              // SizedBox(height: Get.height*0.01,),
              //
              // SizedBox(height: Get.height*0.01,),


         //     controller.property.propertyType=="Plot"?SizedBox():SizedBox(height: Get.height*0.01,),
              controller.property.status!.length==0?SizedBox():AutoSizeText.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: "Property Status: ",
                        style: TextStyle(color: Colors.black54)
                    ),
                    TextSpan(
                        text: "${controller.property.status!.join(",")}",
                        style: TextStyle(color: Colors.black)
                    )
                  ],
                  style: TextStyles.title1
              )),
              // controller.property.propertyNumber!=null?controller.property.propertyNumber!.length==0?SizedBox():SizedBox(height: Get.height*0.01,):SizedBox(),
              controller.property.propertyNumber!=null?controller.property.propertyNumber!.length==0?SizedBox():Row(
                children: [
                  Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor),

                  AutoSizeText.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: "Property Number: ",
                            style: TextStyle(color: Colors.black54)
                        ),
                        TextSpan(
                            text: "${controller.property.propertyNumber!}",
                            style: TextStyle(color: Colors.black)
                        )
                      ],
                      style: TextStyles.title1
                  )),
                ],
              ):SizedBox(),
              controller.property.description!=null?controller.property.description!.length==0?SizedBox():SizedBox(height: Get.height*0.01,):SizedBox(),
              controller.property.description!=null?controller.property.description!.length==0?SizedBox():AutoSizeText.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: "Description: ",
                        style: TextStyle(color: Colors.black54)
                    ),
                    TextSpan(
                        text: "${controller.property.description!.length>30?controller.showMore?controller.property.description:controller.property.description!.substring(0,25):controller.property.description!}",
                        style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                        text: controller.property.description!.length>30?controller.showMore?" show less":" show more":"",
                        style: TextStyles.body1.copyWith(decoration: TextDecoration.underline,color: primaryColor,),
                        recognizer: TapGestureRecognizer()..onTap=()=>{
                          controller.toggleShowMore()
                        }
                    )
                  ],
                  style: TextStyles.title1
              )):SizedBox(),
              controller.property.propertyTitle!=null?controller.property.propertyTitle!.length==0?SizedBox():SizedBox(height: Get.height*0.01,):SizedBox(),
              controller.property.propertyTitle!=null?controller.property.propertyTitle!.length==0?SizedBox():AutoSizeText.rich(TextSpan(
                  children: [
                    TextSpan(text:


                    "${ controller.property.propertyType == "Farm House" ||  controller.property.propertyType == "Commercial" ||  controller.property.propertyType == "Home" ?  controller.property.propertySubType :
                    "${ controller.property.propertySubType} ${ controller.property.propertyType}"} for ${ controller.property.purpose == 0 ? "Sale:" : "Rent"}",
                        style: TextStyle(color: Colors.black54),


                    ),
                    TextSpan(
                        text: "${controller.property.propertyTitle!}",
                        style: TextStyle(color: Colors.black)
                    ),


                    // TextSpan(
                    //     text: "Title: ",
                    //     style: TextStyle(color: Colors.black54)
                    // ),
                    // TextSpan(
                    //     text: "${controller.property.propertyTitle!}",
                    //     style: TextStyle(color: Colors.black)
                    // ),
                  ],
                  style: TextStyles.title1
              )):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}*/
class _StatusView extends GetView<PropertyDetailController> {
  const _StatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.03),
          child: Column(
            children: [
              AutoSizeText(
                "Property Status",
                style: TextStyles.h2
                    .copyWith(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Center(
                child: SizedBox(
                  width: Get.width * 0.3,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Wrap(
                children: [
                  for (String status in controller.property.status!)
                    Container(
                        width: Get.width * 0.4,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: AutoSizeText(
                               status,
                                style: TextStyles.title1,
                              ))
                        ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyTitle extends GetView<PropertyDetailController> {
  const _PropertyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.03),
          child: Column(
            children: [
              AutoSizeText(
                "Property Title",
                style: TextStyles.h2
                    .copyWith(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Center(
                child: SizedBox(
                  width: Get.width * 0.3,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              AutoSizeText(controller.property.propertyTitle!,textAlign: TextAlign.justify,)
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyDescription extends GetView<PropertyDetailController> {
  const _PropertyDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.03),
          child: Column(
            children: [
              AutoSizeText(
                "Property Description",
                style: TextStyles.h2
                    .copyWith(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Center(
                child: SizedBox(
                  width: Get.width * 0.3,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              AutoSizeText(controller.property.description!,textAlign: TextAlign.justify,)
            ],
          ),
        ),
      ),
    );
  }
}


class _KeyFeatures extends GetView<PropertyDetailController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.03),
          child: Column(
            children: [
              AutoSizeText(
                "Key Features",
                style: TextStyles.h2
                    .copyWith(color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Center(
                child: SizedBox(
                  width: Get.width * 0.3,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Wrap(
                children: [
                  for (String feature in controller.property.propertyFeatures!)
                    Container(
                        width: Get.width * 0.4,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: AutoSizeText(
                            feature,
                            style: TextStyles.title1,
                          ))
                        ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AgentDetail extends GetView<PropertyDetailController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: controller.seller != null
          ? Card(
              child: Padding(
                padding: EdgeInsets.all(Get.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Agent Name",
                            style: TextStyles.title1,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          AutoSizeText(
                            "${controller.seller!.name}",
                            style: TextStyles.body1,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          controller.seller!.phoneNumber != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "Agent Phone Number",
                                      style: TextStyles.title1,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    AutoSizeText(
                                      "${controller.seller!.phoneNumber}",
                                      style: TextStyles.body1,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          controller.seller!.estateName != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      controller.seller!.estateName!.isNotEmpty
                                          ? [
                                              AutoSizeText(
                                                "Estate Name",
                                                style: TextStyles.title1,
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              AutoSizeText(
                                                "${controller.seller!.estateName}",
                                                style: TextStyles.body1,
                                              ),
                                            ]
                                          : [],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          controller.property.optionalNumber != null
                              ? GestureDetector(
                                  onTap: () {
                                    controller.showPopup();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "Optional Phone Number",
                                        style: TextStyles.title1,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      AutoSizeText(
                                        "${controller.property.optionalNumber}",
                                        style: TextStyles.body1,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: controller.seller!.imageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: controller.seller!.imageUrl!,placeholder: (_,__){
                                      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),),);
                            },)
                                : Image.asset("assets/person.png"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
