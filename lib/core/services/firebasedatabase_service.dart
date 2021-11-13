

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:propertychowk/models/property.dart';

class FireBaseDatabaseService extends GetxService{

  DatabaseReference _firebaseDatabase=FirebaseDatabase.instance.reference();


  updateProperty(Property property)async{
    try{
      _firebaseDatabase.reference().child("properties").child(property.id!).update(property.toMap());
    }
    catch(e){
      rethrow;
    }
  }

  uploadProperty(Property property)async{
     try{
       _firebaseDatabase.reference().child("properties").push().set(property.toMap());
     }
     catch(e){
       rethrow;
     }
  }

  Future<List<Property>> getAllProperties()async{
    List<Property> properties=[];
    try{
      DataSnapshot snapshot=await _firebaseDatabase.child("properties").once();
      if(snapshot.value!=null){
        Map newProperties=Map.from(snapshot.value);
        newProperties.forEach((key, value) {
          Property property=Property.fromJson(Map.from(value),key);
          properties.add(property);
        });
      }
      return properties;
    }
    catch(e){
      rethrow;
    }
  }

  Stream<Event> onPropertiesUpdateStream(){
    return _firebaseDatabase.child("properties").onChildChanged;
  }

  Stream<Event> onPropertiesAddedStream(){
    return _firebaseDatabase.child("properties").onChildAdded;
  }

  Stream<Event> onPropertiesRemovedStream(){
    return _firebaseDatabase.child("properties").onChildRemoved;
  }
}