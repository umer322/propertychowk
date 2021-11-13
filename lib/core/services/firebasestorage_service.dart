

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FireBaseStorageService extends GetxService{
  var uuid = Uuid();
  Future<List<String>> uploadMultipleImages(List assets) async {
    List<String> _imageUrls = [];

    try {
      for (int i = 0; i < assets.length; i++) {
        if(assets[i].contains("firebasestorage")){
        _imageUrls.add(assets[i]);
        continue;
        }
        File file=File(assets[i]);
        var result = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          minWidth: 900,
          minHeight: 600,
          quality: 90,
        );
        final Reference storageReference = FirebaseStorage.instance.ref().child("property_images/${uuid.v4()}");
        final UploadTask uploadTask = storageReference.putData(result!);

        final StreamSubscription<TaskSnapshot> streamSubscription =
        uploadTask.asStream().listen((event) {
          print('EVENT ${event.state}');
        });

        // Cancel your subscription when done.
        await uploadTask.whenComplete(() => streamSubscription.cancel());


        String imageUrl = await storageReference.getDownloadURL();
        _imageUrls.add(imageUrl); //all all the urls to the list
      }
      return _imageUrls;
    } catch (e) {
      print(e);
      return _imageUrls;
    }
  }

  uploadImage(String image)async{

    if(image.contains("firebasestorage")){
      return;
    }
    final Reference storageReference = FirebaseStorage.instance.ref().child("${uuid.v4()}");
    final UploadTask uploadTask = storageReference.putFile(File(image));

    final StreamSubscription<TaskSnapshot> streamSubscription =
    uploadTask.asStream().listen((event) {
      print(event.bytesTransferred/event.totalBytes);
      print('EVENT ${event.state}');
    });

    // Cancel your subscription when done.
    await uploadTask.whenComplete(() => streamSubscription.cancel());


    return await storageReference.getDownloadURL();

  }

  uploadThumbnail(Uint8List image)async{

    final Reference storageReference = FirebaseStorage.instance.ref().child("${uuid.v4()}");
    final UploadTask uploadTask = storageReference.putData(image);

    final StreamSubscription<TaskSnapshot> streamSubscription =
    uploadTask.asStream().listen((event) {
      print(event.bytesTransferred/event.totalBytes);
      print('EVENT ${event.state}');
    });

    // Cancel your subscription when done.
    await uploadTask.whenComplete(() => streamSubscription.cancel());


    return await storageReference.getDownloadURL();

  }


}