import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/utils/show.dart';

class SearchSociety extends StatefulWidget {

  final String city;
  SearchSociety(this.city);
  @override
  _SearchSocietyState createState() => _SearchSocietyState();
}

class _SearchSocietyState extends State<SearchSociety> {


 // Future<DocumentSnapshot> fetchData() async{
 //
 //    DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("recentSearches").doc(FirebaseAuth.instance.currentUser?.uid).get();
 //
 //    return snapshot;
 //  }
  final st=GetStorage();
  List<String>  societyList=Property.islamabadSocieties;
  List<String>  searchedSocieties=[];

  List<String>? searches=[];
 final storageVal=GetStorage();
  @override
  void initState() {




    // TODO: implement initState
    super.initState();
    print(widget.city);
    if(widget.city=="Islamabad"){
      societyList=Property.islamabadSocieties;
    }
    else if(widget.city=="Rawalpindi"){
      societyList=Property.rawalpindiSocieties;
    }
    else if(widget.city=="Lahore"){
      societyList=Property.lahoreSocieties;
    }
    else if(widget.city=="Gujranwala"){
      societyList=Property.gujranwalaSocieties;
    }
    else if(widget.city=="Multan"){
      societyList=Property.multanSocieties;
    }
    else if(widget.city=="Bahawalpur"){
      societyList=Property.bahawalpurSocieties;
    }
    else{
      societyList=["Others"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Society",style:  TextStyle(color: Colors.black),),automaticallyImplyLeading: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
            child: TextField(
              onChanged: (val){
                if(val.isNotEmpty){
                  List<String> searched=societyList.where((element) => element.toLowerCase().contains(val.toLowerCase().trim())).toList();
                  if(searched.length==0){
                    for(int i=0;i<val.length;i++){
                      searched=societyList.where((element) => element.toLowerCase().contains(val[i].toLowerCase())).toList();
                    }
                    searched=searched.toSet().toList();
                    int max=0;
                    List results=[];
                    searched.forEach((element) {
                      String society=element;
                      int counter=0;
                      for(int i=0;i<val.length;i++){
                        if(val[i]==" "){
                          continue;
                        }
                        if(society.toLowerCase().contains(val[i].toLowerCase())){
                          society= society.replaceFirst(val[i], "");
                          counter+=1;
                        }
                      }
                      if(counter>max){
                        max=counter;
                        results.insert(0, element);
                      }
                      else if(counter==max){
                        results.insert(1, element);
                      }
                      else{
                        results.add(element);
                      }
                    });
                    searched=List.from(results);
                  }
                  setState(() {
                    searchedSocieties.clear();
                   searchedSocieties.addAll(searched);

                  });
                }
                else{
                  setState(() {
                    searchedSocieties.clear();
                  });
                }
              },
              decoration: InputDecoration(hintText: "Search Society",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,



              children: [
                Text("Recent",style: TextStyle(color: Theme.of(context).primaryColor),),

                Container(



                  width: Get.width,
                  height: 100,


                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),

                      borderRadius: BorderRadius.circular(10)),
                  // child:  ListView.builder(
                  //     itemCount: recentSearch.length,
                  //     itemBuilder: (BuildContext context,int index){
                  //
                  //       return ListTile(
                  //         title: Text(recentSearch[index]),onTap: (){
                  //         Navigator.pop(context,recentSearch[index]);
                  //       },
                  //       );
                  //     }),

                  child: FutureBuilder<DocumentSnapshot>(
                    future:  FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).get(),

                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                      if (snapshot.hasError) {
                        return Center(child: Text("Something went wrong",style: TextStyle(color: Colors.red),));
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Center(child: Text("No recent exists"));
                      }
                      if(snapshot.connectionState == ConnectionState.done)
                        {

                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        //  return Text("Full Name: ${data['cities']} ");
                          List list=List.from(data["cities"]);
                            list=list.reversed.toList();
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context,index)=>  ListTile(
                      title: Text(list[index]),onTap: ()async{
                      Navigator.pop(context,list[index]);
                      },
                      ));
                        }
                      return Center(child: CircularProgressIndicator(),);

                    },
                  )



                ),
              ],
            ),
          ),
          searchedSocieties.length==0?Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
              child: ListView.builder(
                  itemCount: societyList.length,
                  itemBuilder: (BuildContext context,int index){
                    return ListTile(
                      title: Text(societyList[index]),onTap: ()async{
                        Show.showLoader();
                        DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).get();
                        if(snapshot.exists){
                          await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).
                          update({"cities":FieldValue.arrayUnion([societyList[index]])});
                        }else{
                          await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).
                          set({"cities":[societyList[index]]});
                        }
                      if(Get.isOverlaysOpen){
                        Get.back();
                      }
                      Navigator.pop(context,societyList[index]);
                    },
                    );
                  }),
            ),
          ):Expanded(
            child: ListView.builder(
                itemCount: searchedSocieties.length,
                itemBuilder: (BuildContext context,int index){

                  return ListTile(
                    title: Text(searchedSocieties[index]),onTap: ()async{
                        Show.showLoader();
                         DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).get();
                         if(snapshot.exists){
                           await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).
                           update({"cities":FieldValue.arrayRemove([searchedSocieties[index]])});
                          await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).
                           update({"cities":FieldValue.arrayUnion([searchedSocieties[index]])});
                         }else{
                           await FirebaseFirestore.instance.collection("recent").doc(FirebaseAuth.instance.currentUser?.uid).
                           set({"cities":[searchedSocieties[index]]});
                         }
                        if(Get.isOverlaysOpen){
                          Get.back();
                        }
                      Navigator.pop(context,searchedSocieties[index]);

                  },
                  );
                }),
          )
        ],
      ),
    );
  }


}
