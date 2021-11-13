import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RippleButton extends StatelessWidget{
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool? border;
  final Color? borderColor;
  final Color? titleColor;
  final String? title;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? splashColor;
  final Color? backGroundColor;
  final double? borderWidth;
  final MaterialColor? shadowColor;
  final bool? addShadow;
  final double? elevation;
  RippleButton({this.elevation,this.shadowColor,this.addShadow=false,this.height,this.fontSize,this.borderWidth=1,this.splashColor,this.borderColor,this.title,this.borderRadius,this.width,this.backGroundColor,this.border=false,this.titleColor,@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: elevation??0,
        borderRadius: borderRadius,
        color: backGroundColor??Colors.white,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          splashColor: splashColor??Get.theme.splashColor,
          child: Container(
            constraints: BoxConstraints(minWidth: 100,maxWidth:kIsWeb?400:Get.width),
            decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: borderRadius,
              border: border??false?Border.all(color: borderColor??Get.theme.primaryColor,width: borderWidth??0):Border.all(width: 0,color: Colors.transparent),
              boxShadow: addShadow??false?[
                BoxShadow(
                    color: shadowColor!.shade200,
                    offset: Offset(1, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: shadowColor!.shade200,
                    offset: Offset(-1, 2),
                    blurRadius: 5)
              ]:[]
            ),
            width: width??90,
            height: height??60,
            child: title!=null?Center(
              child: Text("$title",style: TextStyle(color: titleColor??Get.theme.backgroundColor,fontSize: fontSize),textAlign: TextAlign.center,),
            ):SizedBox(),
          ),
        ),
      ),
    );
  }

}