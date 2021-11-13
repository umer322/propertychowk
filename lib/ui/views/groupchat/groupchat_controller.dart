

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propertychowk/core/controllers/chat_controller.dart';
import 'package:propertychowk/core/controllers/user_controller.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/core/services/multimedia_service.dart';
import 'package:propertychowk/models/message.dart';
import 'package:propertychowk/models/user.dart';
import 'package:propertychowk/utils/colors.dart';
import 'package:propertychowk/utils/show.dart';
import 'package:propertychowk/utils/styles.dart';

class GroupChatController extends GetxController{

  //message on which we reply
  AppMessage? currMessage;


  FocusNode? myFocusNode;
  RxBool isRep=false.obs;
  isReply(bool isreply)
  {
    this.isRep=isreply.obs;
    update();
  }


    late List<AppMessage> messages;
    late AppUser currentUser;
    String? imageUrl;
    late TextEditingController chatController;


    listenToChatMessages(){
      messages=Get.find<ChatController>().messages;
      Get.find<ChatController>().messages.listen((data) {
        messages=data;
        update();
      });
    }


    @override
  void onInit() {
      this.isReply(false);

      myFocusNode=FocusNode();
    listenToChatMessages();
    setCurrentUser();
    chatController=TextEditingController();
    super.onInit();
  }

  setCurrentUser(){
      currentUser=Get.find<UserController>().currentUser.value;
      Get.find<UserController>().currentUser.listen((data) {
        currentUser=data;
      });
  }

    getChatImage()async{
      final multiMediaService=Get.find<MultiMediaService>();
      SelectImage? type=await multiMediaService.selectImageFrom();
      if(type!=null){
        String? image=await multiMediaService.pickImage(type);
        if(image!=null){
          imageUrl=image;
          update();
        }
      }
    }


    showDeletePopup(AppMessage message){
      Get.defaultDialog(
          title: "Delete Message",
          titleStyle: TextStyles.h2.copyWith(color: Colors.black),
          content: AutoSizeText("Are you sure you want to delete this message?"),
          textCancel:"Cancel",
          onCancel: (){
            Get.back();
          },
          textConfirm:"Yes",
          buttonColor: primaryColor,
          onConfirm: (){
            Get.back();
            try{
              Get.find<FireStoreService>().deleteMessage(message);
            }
            catch(e){
              Show.showErrorSnackBar("Error", "$e");
            }

          }
      );
    }
sendReply(){
      List<String>? oldReply=this.currMessage?.replies;
      oldReply?.add(this.chatController.text);
      this.currMessage?.replies=oldReply;

     // Get.find<FireStoreService>().addReply(this.currMessage!);
     //
     //  update();


}

    addChatMessage()async{
        AppMessage message=AppMessage();
        message.userId=currentUser.id;
        message.message=chatController.text;
        message.time=DateTime.now();
        message.senderName=currentUser.name;
        if(imageUrl!=null){
          message.isMedia=true;
          message.mediaUrl=imageUrl;
          message.loading=true;
        }
        else{
          message.isMedia=false;
          message.loading=false;
        }
        chatController.clear();
        Get.find<ChatController>().addChatMessage(message);
        imageUrl=null;
        update();
    }
    String getDate(DateTime date){
      DateTime now=DateTime.now();
      if(date.day==now.day && date.month==now.month&&date.year==now.year){
        return DateFormat.jm().format(date);
      }
      else if(date.day!=now.day && date.month==now.month&&date.year==now.year){
        return DateFormat.MMMd().format(date)+" AT "+DateFormat.jm().format(date);
      }
      else if( date.month!=now.month){
        return DateFormat.MMMd().format(date)+" AT "+DateFormat.jm().format(date);
      }
      else{
        return "";
      }
    }

    @override
  void onClose() {
    chatController.dispose();
    super.onClose();
  }
}