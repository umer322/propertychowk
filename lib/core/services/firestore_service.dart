import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:propertychowk/models/message.dart';
import 'package:propertychowk/models/user.dart';

class FireStoreService extends GetxService {
  CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");
  CollectionReference _packagesCollection = FirebaseFirestore.instance.collection("packages");
  CollectionReference _chatCollection = FirebaseFirestore.instance.collection("chat");


  Stream<DocumentSnapshot> fireStoreUserStream(String userId){
    return _userCollection.doc(userId).snapshots();
  }

  updateUser(AppUser user){
    try{
      _userCollection.doc(user.id).update(user.toMap());
    }
    catch(e){
      rethrow;
    }
  }

  addFavorite(String userId,String id)async{
    try{
      await _userCollection.doc(userId).update({"favorites":FieldValue.arrayUnion([id])});
    }
    catch(e){
      rethrow;
    }
  }

  removeFavorite(String userId,String id)async{
    try{
      await _userCollection.doc(userId).update({"favorites":FieldValue.arrayRemove([id])});
    }
    catch(e){
      rethrow;
    }
  }
  Future saveUser(String id,AppUser user)async{
    try{
      _userCollection.doc(id).set(user.toMap());
    }
    catch(e){
      rethrow;
    }
  }

  Stream<QuerySnapshot> getUsersStream(){
    return _userCollection.snapshots();
  }

  Stream<QuerySnapshot> chatMessagesStream(){
    return _chatCollection.snapshots();
  }

  addNewMessage(AppMessage message)async{
    try{
     DocumentReference reference=await _chatCollection.add(message.toMap());
     return reference.id;
    }
    catch(e){
      rethrow;
    }
  }

  addReply(AppMessage message)
  {
    _chatCollection.doc(message.id).update(message.toMap()).then((value){

      print("updated");
    });
  }

  deleteMessage(AppMessage message)async{
    try{
     await  _chatCollection.doc(message.id).delete();
    }
    catch(e){
      rethrow;
    }
  }

  updateMessage(AppMessage message)async{
    try{
      await _chatCollection.doc(message.id).update(message.toMap());
    }
    catch(e){
      rethrow;
    }
  }

  getUserData(String id)async{
    try{
      DocumentSnapshot snapshot=await _userCollection.doc(id).get();
      if(snapshot.exists){
        AppUser user=AppUser.fromJson(Map.from(snapshot.data()as Map), snapshot.id);
        return user;
      }
      return null;
    }
    catch(e){
      rethrow;
    }
  }

  Stream<QuerySnapshot> packagesStream(){
    return _packagesCollection.snapshots();
  }
}