import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/propertyThumbnail/propertythumbnail_view.dart';

class PropertyListView extends StatelessWidget {
  final String name;
  final List<Property> properties;
  PropertyListView(this.name,this.properties);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(name),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.01),
          itemCount: properties.length,
          itemBuilder: (context,index){
        return PropertyThumbnailView(properties[index]);
      }),
    );
  }
}
