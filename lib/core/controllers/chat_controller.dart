
import 'dart:async';
import 'package:get/get.dart';
import 'package:propertychowk/core/services/firebasestorage_service.dart';
import 'package:propertychowk/core/services/firestore_service.dart';
import 'package:propertychowk/models/message.dart';

class ChatController extends GetxService{
    RxList<AppMessage> messages=RxList();
    late StreamSubscription chatMessageSubscription;

    listenToChatMessages(){
      chatMessageSubscription=Get.find<FireStoreService>().chatMessagesStream().listen((event) {
        List<AppMessage> chatMessages= event.docs.map((e) => AppMessage.fromJson(Map.from(e.data() as Map),e.id)).toList();
        chatMessages.sort((a,b)=>b.time!.compareTo(a.time!));
        messages.clear();
        messages.addAll(chatMessages);
      });
    }

    addChatMessage(AppMessage message)async{
      try{
        String id=await Get.find<FireStoreService>().addNewMessage(message);
        message.id=id;
        if(message.mediaUrl!=null){
          String image=await Get.find<FireBaseStorageService>().uploadImage(message.mediaUrl!);
          message.loading=false;
          message.mediaUrl=image;
          await Get.find<FireStoreService>().updateMessage(message);
        }
      }
      catch(e){
        rethrow;
      }
    }




    @override
  void onInit() {
    listenToChatMessages();
    super.onInit();
  }
  @override
  void onClose() {
    chatMessageSubscription.cancel();
    super.onClose();
  }
}