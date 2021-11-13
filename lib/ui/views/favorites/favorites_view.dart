import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/favorites/favorites_controller.dart';
import 'package:propertychowk/ui/views/propertyThumbnail/propertythumbnail_view.dart';
import 'package:propertychowk/utils/styles.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
        init: FavoritesController(),
        builder: (controller){
      return Scaffold(
        appBar: AppBar(
          title: AutoSizeText("Favorites(${controller.favoriteProperties.length})",style: TextStyles.h2.copyWith(color: Colors.black),),
          centerTitle: true,
        ),
        body: ListView.builder(
                itemCount: controller.favoriteProperties.length,
                itemBuilder: (context,index){
                  return PropertyThumbnailView(controller.favoriteProperties[index]);
                }));
    });
  }
}
