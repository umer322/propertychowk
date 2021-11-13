import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/propertydetail/propertydetail_view.dart';
import 'package:propertychowk/utils/styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class PropertyThumbnailView extends StatelessWidget {
  final Property property;
  PropertyThumbnailView(this.property);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>PropertyDetailView(property));
      },
      child: Container(
        height: Get.height*0.27,
        width: Get.width,
        child: Card(
          elevation: 8,
          child: Padding(
            padding:  EdgeInsets.all(Get.width*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Expanded(child: Stack(
                 fit: StackFit.expand,
                 children: [
                   Card(
                     margin: EdgeInsets.all(0),
                     shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     child: ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: property.propertyImages!.length>0?CachedNetworkImage(imageUrl: property.propertyImages![0],fit: BoxFit.cover,):property.propertyVideoThumbnail!=null?Stack(fit:StackFit.expand,children: [CachedNetworkImage(imageUrl: property.propertyVideoThumbnail!,fit: BoxFit.cover,),Positioned(
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
                             )),],):Image.asset(property.propertyType=="Plot"?"assets/plot.jpeg":"assets/background.png",fit: property.propertyType=="Plot"?BoxFit.cover:BoxFit.contain,)),
                   ),
                   property.featured!?
                   Positioned(
                       top: 0,
                       left: 0,
                       child: Container(
                         padding: EdgeInsets.symmetric(
                             horizontal: Get.width*0.04,
                             vertical: Get.width*0.01
                         ),
                         decoration: BoxDecoration(
                             gradient: LinearGradient(colors: [Colors.red[900]!,Colors.red[600]!]),
                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))
                         ),
                         child: AutoSizeText(property.featureType==0?"SUPER HOT":"HOT",style: TextStyles.h3.copyWith(color:Colors.white),),
                       ))
                       :SizedBox()
                 ],
               ),),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
                  child: Row(children: [
                    Icon(Icons.home,color: Colors.black,),
                    AutoSizeText("${property.propertyType=="Home"||property.propertyType=="Commercial"?property.propertySubType:"${property.propertySubType} ${property.propertyType}"} For ${property.purpose==0?"Sale":"Rent"}",style: TextStyles.caption.copyWith(color: Theme.of(context).primaryColor),),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: AutoSizeText(timeago.format(property.date!),style: TextStyle(color: Colors.white),)),
                    )

                  ],),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
                  child: AutoSizeText.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: "PKR ",
                            style: TextStyles.h3.copyWith(fontWeight: FontWeight.w400)
                        ),
                        TextSpan(text: "${Property.buildPrice(property.propertyPrice!)}")
                      ],
                      style: TextStyles.h3
                  ),textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
                  child: AutoSizeText("${property.block!.isNotEmpty?property.block!.contains("lock")?property.block!.toUpperCase()+", ":"Block ${property.block!.toUpperCase()}"+", ":""}"
                      "${property.phase!.isNotEmpty?property.phase!.contains("hase")?property.phase!+", ":"Phase ${property.phase}"+",":""} "
                      "${property.society!.isNotEmpty?property.society!+", ":""}${property.city}",style: TextStyles
                      .body3.copyWith(fontWeight: FontWeight.w400),),
                ),
                SizedBox(height: Get.height*0.01,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(children: [
                          property.propertyType=="Plot"?SizedBox():Row(
                            children: [
                              Icon(Icons.bed_outlined,color: Colors.black38,size: 14,),
                              SizedBox(width: 5,),
                              AutoSizeText("${property.bedrooms ??0}",style: TextStyle(fontSize: FontSizes.s10),)
                            ],
                          ),
                         property.propertyType=="Plot"?SizedBox():SizedBox(width: Get.width*0.04,),
                         property.propertyType=="Plot"?SizedBox():Row(
                            children: [
                              Icon(Icons.bathtub_outlined,color: Colors.black38,size: 14,),
                              SizedBox(width: 5,),
                              AutoSizeText("${property.bathrooms??0}",style: TextStyle(fontSize: FontSizes.s10),)
                            ],
                          ),
                          property.propertyType=="Plot"?SizedBox():SizedBox(width: Get.width*0.04,),
                          Row(
                            children: [
                              Icon(Icons.crop,color: Colors.black38,size: 14,),
                              SizedBox(width: 5,),
                              AutoSizeText("${property.propertyArea} ${property.areaType}",style: TextStyle(fontSize: FontSizes.s10),)
                            ],
                          ),
                        ],),
                      ),
                      property.propertyNumber!=null?property.propertyNumber!.split(",").length>1?AutoSizeText(property.propertyNumber!.split(",").length==2?"Pair":property.propertyNumber!.split(",").length==3?"Triple":"Terta",style: TextStyle(color: Colors.red),):SizedBox():SizedBox(),
                      SizedBox(width: 5,),
                      Get.find<UserController>().currentUser.value.id !=
                          property.sellerId
                          ? Obx((){
                            return IconButton(icon: Icon(Get.find<UserController>().currentUser.value.favorites!.contains(property.id!)?Icons.favorite:Icons.favorite_border),
                              onPressed: (){
                                Get.find<UserController>().addFavoriteProperty(property.id!);
                              },
                              color: Theme.of(context).primaryColor,
                            );
                          })
                          : SizedBox(),
                      SizedBox(width: 5,),
                       ],
                  ),
                ),
                SizedBox(height: Get.height*0.005,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
