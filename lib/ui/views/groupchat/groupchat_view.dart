import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/models/message.dart';
import 'package:propertychowk/ui/views/groupchat/groupchat_controller.dart';
import 'package:propertychowk/ui/views/tabs/tabs_controller.dart';
import 'package:propertychowk/ui/widgets/appprogress_indicatior.dart';
import 'package:propertychowk/utils/styles.dart';


class GroupChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<GroupChatController>(
        init: GroupChatController(),
        builder: (model){
          return WillPopScope(child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              // actions: [
              //   Padding(
              //     padding: EdgeInsets.all(4),
              //     child: AutoSizeText("Group Chat",style: TextStyles.h3.copyWith(color: Colors.black),),
              //   ),
              //   Padding(
              //     padding: EdgeInsets.all(4),
              //     child: CircleAvatar(
              //
              //       backgroundColor: Colors.transparent,
              //
              //
              //       child: Image.asset("assets/mawjoodIcon.png"),),
              //   ),
              //
              //
              // ],

              centerTitle: true,
              title: Image.asset("assets/display.png",width: Get.width*0.3,),),
            backgroundColor: Color(0xfff5f6fa),
            body:Padding(
              padding: EdgeInsets.only(bottom: Get.height*0.025,left: Get.width*0.05,right:Get.width*0.05),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                    reverse: true,
                    itemCount: model.messages.length,
                    itemBuilder: (_,index,){


                      bool isSender=Get.find<UserController>().currentUser.value.id==model.messages[index].userId;
                      return isSender
                          ? Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onLongPress: (){
                                  model.showDeletePopup(model.messages[index]);
                                },
                                child: Bubble(
                                  nip: BubbleNip.rightTop,
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      model.messages[index].isMedia!?Container(height: Get.height*0.2,width: Get.width*0.4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            model.messages[index].loading!?Center(child: AppProgressIndication(),):Expanded(child: GestureDetector(
                                                onTap: (){

                                                },
                                                child: CachedNetworkImage(imageUrl: model.messages[index].mediaUrl??"",))),
                                            SizedBox(height: 5,),
                                            model.messages[index].message!=""?Flexible(
                                              child: AutoSizeText(
                                                model.messages[index].message!,
                                                textDirection:
                                                TextDirection.ltr,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                presetFontSizes: [16, 14],
                                              ),
                                            ):SizedBox()
                                          ],),
                                      ):Row(mainAxisSize: MainAxisSize.min,children: [
                                        Flexible(
                                          child: AutoSizeText(
                                            model.messages[index].message!,
                                            textDirection:
                                            TextDirection.ltr,
                                            style: TextStyle(
                                                color: Colors.black),
                                            presetFontSizes: [16, 14],
                                          ),
                                        )
                                      ],),
                                      SizedBox(height: 3,),
                                      AutoSizeText(model.getDate(model.messages[index].time!),style: TextStyle(color: Colors.black54),)
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                          : Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: Get.height*0.01,),
                            AutoSizeText(model.messages[index].senderName??"User",style: TextStyles.h3,),
                            SizedBox(height: Get.height*0.01,),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child:
                                    Bubble(
                                      nip: BubbleNip.leftBottom,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          model.messages[index].isMedia??false?Container(height: Get.height*0.2,width: Get.width*0.4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                model.messages[index].loading!?Center(child: AppProgressIndication(),):Expanded(child: GestureDetector(
                                                    onTap: (){

                                                    },
                                                    child: CachedNetworkImage(imageUrl: model.messages[index].mediaUrl!))),
                                                SizedBox(height: 5,),
                                                model.messages[index].message!=""?Flexible(
                                                  child: AutoSizeText(
                                                    model.messages[index].message!,
                                                    textDirection:
                                                    TextDirection.ltr,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    presetFontSizes: [16, 14],
                                                  ),
                                                ):SizedBox()
                                              ],),
                                          ):Row(mainAxisSize: MainAxisSize.min,children: [
                                            Flexible(
                                              child: AutoSizeText(
                                                model.messages[index].message??'',
                                                textDirection:
                                                TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                presetFontSizes: [16, 14],
                                              ),
                                            ),

                                          ],),
                                          SizedBox(height: 3,),
                                          AutoSizeText(model.getDate(model.messages[index].time!),style: TextStyle(color: Colors.black54),),

                                        ],
                                      ),
                                    )),


                                Expanded(flex: 1, child: SizedBox())
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
            ,),
                  Row(
                    children: [
                      Expanded(child:Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: model.imageUrl==null?0:Get.height*0.2,
                              child: model.imageUrl==null?SizedBox():Stack(
                                fit: StackFit.expand,
                                children: [
                               Image.file(File(model.imageUrl!)),
                                Positioned(
                                  top: 15,
                                  right: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        shape: BoxShape.circle
                                    ),
                                    child: IconButton(icon: Icon(Icons.cancel_outlined,color: Colors.black,), onPressed: (){
                                      model.imageUrl=null;
                                      model.update();
                                    },iconSize: 30,),
                                  ),
                                )
                              ],),
                            ),
                            Row(children: [
                              Flexible(child: TextField(
                                focusNode: model.myFocusNode,
                                onChanged: (val){
                                  model.update();
                                },
                                controller: model.chatController,
                                decoration: InputDecoration(
                                  filled: false,
                                    border: InputBorder.none,
                                    hintText: 'Type Message'.tr,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: Colors.white)),
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: Colors.white)),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: Colors.white)),
                                ),
                              )),
                              IconButton(icon: Icon(Icons.image_outlined,color: Colors.black,), onPressed: (){
                                model.getChatImage();
                              })
                            ],)
                          ],
                        ),
                      ),),
                      IconButton(icon: Icon(Icons.send,color: model.chatController.text.length==0?Colors.grey:Colors.black,), onPressed: model.chatController.text.length==0&&model.imageUrl==null?null:(){
                  model.isRep.value==true?model.sendReply():      model.addChatMessage();
                        FocusScope.of(context).requestFocus(FocusNode());
                      })
                    ],
                  )
                ],
              ),
            ),
          ), onWillPop: ()async{


            if(MediaQuery.of(context).viewInsets.bottom!=0){
              FocusScope.of(context).requestFocus(FocusNode());
              return false;
            }
            return true;
          });
        });
  }
}
