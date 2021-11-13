import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propertychowk/utils/colors.dart';

class AppProgressIndication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(primaryColor),):CupertinoActivityIndicator();
  }
}
