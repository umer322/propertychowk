import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/home/home_controller.dart';
import 'package:propertychowk/ui/views/propertydetail/propertydetail_view.dart';
import 'package:propertychowk/ui/views/propertylist/propertylist_view.dart';
import 'package:propertychowk/ui/views/tabs/tabs_controller.dart';
import 'package:propertychowk/ui/widgets/drawer/drawer_view.dart';
import 'package:propertychowk/ui/widgets/search_cities.dart';
import 'package:propertychowk/ui/widgets/search_society.dart';
import 'package:propertychowk/utils/colors.dart';
import 'package:propertychowk/utils/styles.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: ()=>Get.find<TabsController>().checkBackButtonFunctionality(),
            child: Scaffold(
             backgroundColor: Theme.of(context).primaryColor,
              key: _scaffoldKey,
              drawer: DrawerView(),
              body: Container(

                height: Get.height,
                width: Get.width,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.white),
                    //   flexibleSpace: Container(
                    //
                    //   decoration: BoxDecoration(
                    // color: Colors.lightBlue.shade50,
                    //        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                    //
                    //   ),
                    //
                    //   ),
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
//
// bottomRight: Radius.circular(20),
//     bottomLeft: Radius.circular(20)),),

                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.05),
                          child: GestureDetector(
                            onTap: () async {
                              String? city = await Get.to(() => SearchCities());
                              if (city != null) {
                                controller.setCity(city);
                                String? society =
                                    await Get.to(() => SearchSociety(city));
                                if (society != null) {
                                  controller.setSociety(city, society);
                                }
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding: EdgeInsets.all(Get.width * 0.04),
                                child: Icon(Icons.tune, color: primaryColor),
                              ),
                            ),
                          ),
                        )
                      ],
                  //  backgroundColor: Color(0xfff5f6fa),
                     backgroundColor: Theme.of(context).primaryColor,


                      title: Image.asset(
                        "assets/display-white.png",
                        color: Colors.white,
                        width: Get.width * 0.4,
                        height: Get.width * 0.4,
                      ),

                      centerTitle: true,

                      expandedHeight: 100.0,
                      floating: true,
                      pinned: true,
                      //  snap: true,
                      elevation: 0.0,
                    ),

                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.societyController.text.length == 0
                              ? AutoSizeText(
                                  "",
                                  style: TextStyles.h2,
                                )
                              : Flexible(
                                  child: Container(

                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.04,
                                        vertical: Get.width * 0.01),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                            child: AutoSizeText(
                                          controller.societyController.text,
                                          maxLines: 1,
                                          style: TextStyles.h2
                                              .copyWith(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                          presetFontSizes: [FontSizes.s14],
                                        )),
                                        SizedBox(
                                          width: Get.width * 0.03,
                                        ),
                                        GestureDetector(
                                            onTap: controller.showDeletePopup,
                                            child: Icon(Icons.cancel))
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: controller.superHotProperties.length > 0
                          ? Container(
                        decoration: BoxDecoration(


                            color: Color(0xfff5f6fa),

                            shape: BoxShape.rectangle,borderRadius:BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)) ),
                            child: _PropertyListPortion(
                                "Super Hot", controller.superHotProperties, () {
                                Get.to(() => PropertyListView(
                                    "Super Hot", controller.superHotProperties));
                              }),
                          )
                          : SizedBox(),
                    ),
                    SliverToBoxAdapter(
                      child: controller.hotProperties.length > 0
                          ? Container(
                        color: Color(0xfff5f6fa),
                            child: _PropertyListPortion("Hot", controller.hotProperties,
                                () {
                                Get.to(() => PropertyListView(
                                    "Hot", controller.hotProperties));
                              }),
                          )
                          : SizedBox(),
                    ),
                    SliverToBoxAdapter(
                      child:
                          Container(
                            color: Color(0xfff5f6fa),
                            child: _PropertyListPortion("Latest", controller.properties, () {
                        Get.to(() =>
                              PropertyListView("Latest", controller.properties));
                      }),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _PropertyListPortion extends StatelessWidget {
  final String title;
  final List<Property> data;
  final VoidCallback onPressed;

  _PropertyListPortion(this.title, this.data, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                title + "(${data.length})",
                style: TextStyles.h1.copyWith(fontSize: FontSizes.s10),
              ),
              TextButton(onPressed: onPressed, child: AutoSizeText("View All"))
            ],
          ),
        ),
        Container(
          height: Get.width * 0.7,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (_, index) {
                return _PropertyDetailPortion(data[index]);
              }),
        )
      ],
    );
  }
}

class _PropertyDetailPortion extends StatelessWidget {
  final Property property;

  _PropertyDetailPortion(this.property);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PropertyDetailView(property));
      },
      child: Container(
        margin: EdgeInsets.only(left: Get.width * 0.05),
        height: Get.width * 0.7,
        width: Get.width * 0.55,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(Get.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [

                          Card(
                            margin: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: property.propertyImages!.length > 0
                                    ? Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.center,
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: property.propertyImages![0],
                                            fit: BoxFit.cover,
                                          ),
                                        
                                        Image.asset("assets/flag.png",width: Get.width*0.1,fit: BoxFit.contain,height: Get.width*0.1,)
                                      ],
                                    )
                                    : property.propertyVideoThumbnail != null
                                        ? Stack(
                                            fit: StackFit.expand,
                                            children: [

                                              CachedNetworkImage(
                                                imageUrl: property
                                                    .propertyVideoThumbnail!,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                  right: 0,
                                                  bottom: 0,
                                                  left: 0,
                                                  top: 0,
                                                  child: Center(
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )),


                                            ],
                                          )
                                        : Image.asset(
                                            property.propertyType == "Plot"
                                                ? "assets/plot2.png"
                                                : "assets/background2.png",
                                            fit: property.propertyType == "Plot"
                                                ? BoxFit.cover
                                                : BoxFit.contain,
                                          )),
                          ),

                          property.featured!
                              ? Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.04,
                                        vertical: Get.width * 0.01),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.red[900]!,
                                          Colors.red[600]!
                                        ]),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20))),
                                    child: AutoSizeText(
                                      property.featureType == 0
                                          ? "SUPER HOT"
                                          : "HOT",
                                      style: TextStyles.h4.copyWith(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ))
                              : SizedBox()
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            // child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 10, vertical: 5),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(25),
                            //       color: Theme.of(context).primaryColor,
                            //     ),
                            //     child: AutoSizeText(
                            //       "${property.propertyType == "Farm House" || property.propertyType == "Commercial" || property.propertyType == "Home" ? property.propertySubType : "${property.propertySubType} ${property.propertyType}"} for ${property.purpose == 0 ? "Sale" : "Rent"}",
                            //       style: TextStyle(color: Colors.white),
                            //     )),

                            child:      property.propertyTitle == null
                                ? Container()
                                : property.propertyTitle!.isEmpty?SizedBox(): Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width*0.03, vertical: Get.width*0.01),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Text(
                                    "${property.propertyTitle}",
                                    overflow: TextOverflow.ellipsis,


                                    style: TextStyles.body3.copyWith(
                                      color: Colors.white,
                                        fontWeight: FontWeight.normal, fontSize: 14),
                                  )
                            ),
                          ),
                        ),
                      ],
                    ),
                AutoSizeText(
                  "${property.propertyType == "Farm House" || property.propertyType == "Commercial" || property.propertyType == "Home" ? property.propertySubType : "${property.propertySubType} ${property.propertyType}"} for ${property.purpose == 0 ? "Sale" : "Rent"}",
                  style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                ),
                    AutoSizeText.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: "PKR ",
                            style: TextStyles.h3
                                .copyWith(fontWeight: FontWeight.w400)),
                        TextSpan(
                            text:
                                "${Property.buildPrice(property.propertyPrice!)}")
                      ], style: TextStyles.h3),
                      textAlign: TextAlign.start,
                    ),
                    AutoSizeText("${property.block!.isNotEmpty?property.block!.contains("lock")?property.block!.toUpperCase()+", ":"Block ${property.block!.toUpperCase()}"+", ":""}"
                        "${property.phase!.isNotEmpty?property.phase!.contains("hase")?property.phase!+", ":"Phase ${property.phase}"+",":""} "
                        "${property.society!.isNotEmpty?property.society!+", ":""}${property.city}",style: TextStyles
                        .body3.copyWith(fontWeight: FontWeight.w400),),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      children: [
                        property.propertyType == "Plot" ||
                                property.propertyType == "Commercial"
                            ? SizedBox()
                            : Flexible(
                                child: Row(
                                children: [
                                  Icon(
                                    Icons.bed_outlined,
                                    color: Colors.black38,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AutoSizeText(
                                    "${property.bedrooms ?? 0}",
                                    style: TextStyle(fontSize: FontSizes.s10),
                                  )
                                ],
                              )),
                        property.propertyType == "Plot"
                            ? SizedBox()
                            : Flexible(
                                child: Row(
                                children: [
                                  Icon(
                                    Icons.bathtub_outlined,
                                    color: Colors.black38,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AutoSizeText(
                                    "${property.bathrooms ?? 0}",
                                    style: TextStyle(fontSize: FontSizes.s10),
                                  )
                                ],
                              )),
                        property.propertyNumber != null
                            ? property.propertyNumber!.split(",").length > 1
                                ? AutoSizeText(
                                    property.propertyNumber!
                                                .split(",")
                                                .length ==
                                            2
                                        ? "Pair"
                                        : property.propertyNumber!
                                                    .split(",")
                                                    .length ==
                                                3
                                            ? "Triple"
                                            : "Terta",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : SizedBox()
                            : SizedBox(),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.crop,
                                color: Colors.black38,
                                size: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              AutoSizeText(
                                "${property.propertyArea} ${property.areaType}",
                                style: TextStyle(fontSize: FontSizes.s10),
                              )
                            ],
                          ),
                        ),
                        Get.find<UserController>().currentUser.value.id !=
                                property.sellerId
                            ? Flexible(
                              child: Obx((){
                                return IconButton(icon: Icon(Get.find<UserController>().currentUser.value.favorites!.contains(property.id!)?Icons.favorite:Icons.favorite_border),
                                  onPressed: (){
                                    Get.find<UserController>().addFavoriteProperty(property.id!);
                                  },
                                  color: Theme.of(context).primaryColor,
                                );
                              }),
                            )
                            : SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Center(
            //     child: Text(Get.find<HomeController>().waterMark,
            //         style: TextStyles.body2.copyWith(
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white.withOpacity(0.9)))),
          ],
        ),
      ),
    );
  }
}
