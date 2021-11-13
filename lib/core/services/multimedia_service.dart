

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum SelectImage{
  fromCamera,
  fromGallery
}


class MultiMediaService extends GetxService{

  getImages(BuildContext context,int limit)async{
    List<String> images=[];
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(context,maxAssets: limit,textDelegate: EnglishTextDelegate());
    if(assets!=null){
      for(AssetEntity asset in assets){
        File? file=await asset.file;
        images.add(file!.path);
      }
    }
    return images;
  }

  getVideo(BuildContext context,{List<AssetEntity>? selectedAssets})async{
    List<String> videos=[];
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(context,maxAssets: 1,selectedAssets: selectedAssets,requestType: RequestType.video,textDelegate: EnglishTextDelegate());
    if(assets!=null){
      for(AssetEntity asset in assets){
        File? file=await asset.file;
        videos.add(file!.path);
      }
    }
    return videos;
  }

  final picker = ImagePicker();


  Future<String?> pickImage(SelectImage type)async{
    PickedFile? pickedFile ;
    if(type==SelectImage.fromGallery){
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }else{
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }
    return pickedFile?.path;
  }

  Future<String?> cropImage(String image)async{
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: image,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    return croppedFile?.path;
  }


  Future<SelectImage?> selectImageFrom()async{
    return await Get.defaultDialog(title: "Select Image",middleText: "",
      titleStyle: TextStyle(color: Colors.black),
      cancel: ElevatedButton(onPressed: (){
        Get.back(result: SelectImage.fromGallery);
      },child: Text("Gallery",style: TextStyle(color: Colors.white),),
      ),confirm: ElevatedButton(onPressed: (){
        Get.back(result: SelectImage.fromCamera);
      },child: Text("Camera",style: TextStyle(color: Colors.white),),
      ),);
  }

}