import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:propertychowk/models/property.dart';

class SearchCities extends StatefulWidget {
  static Route route(){
    return MaterialPageRoute(builder: (_)=>SearchCities());
  }

  @override
  _SearchCitiesState createState() => _SearchCitiesState();
}

class _SearchCitiesState extends State<SearchCities> {

  List<String>  searchedCities=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select City",style: TextStyle(color: Colors.black),),automaticallyImplyLeading: true,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
            child: TextField(
              onChanged: (val){
                if(val.isNotEmpty){
                  List<String> searched=Property.cities.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
                  List<String> searched1=Property.popularCities.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
                  setState(() {
                    searchedCities.clear();
                    searchedCities.addAll(searched);
                    searchedCities.addAll(searched1);
                  });
                }
                else{
                  setState(() {
                    searchedCities.clear();
                  });
                }
              },
              decoration: InputDecoration(hintText: "Search Location",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ),
          searchedCities.length==0?Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
              child: ListView(
                children: [
                  AutoSizeText("Popular Cities",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  for(String city in Property.popularCities)
                    ListTile(title: Text(city),onTap: (){
                      Navigator.pop(context,city);
                    }),
                  AutoSizeText("Other Cities",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  for(String city in Property.cities)
                    ListTile(title: Text(city),onTap: (){
                      Navigator.pop(context,city);
                    },)
                ],
              ),
            ),
          ):Expanded(
            child: ListView.builder(
                itemCount: searchedCities.length,
                itemBuilder: (BuildContext context,int index){
              return ListTile(
                title: Text(searchedCities[index]),onTap: (){
                Navigator.pop(context,searchedCities[index]);
              },
              );
            }),
          )
        ],
      ),
    );
  }
}
