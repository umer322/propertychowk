import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/core/services/firebaseauth_service.dart';
import 'package:propertychowk/ui/views/favorites/favorites_view.dart';
import 'package:propertychowk/utils/styles.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(child: Center(
              child: Image.asset("assets/display.png"),
            )),
            ListTile(
              onTap: (){
                Get.toNamed("/profile");
              },
              leading: Icon(Icons.person_outline,size: 30,),
              title: AutoSizeText("Profile",style: TextStyles.h3,),
            ),
            ListTile(
              onTap: (){
                Get.back();
                Get.toNamed("/addproperty");
              },
              leading: Icon(Icons.home,size: 30,),
              title: AutoSizeText("Add Property",style: TextStyles.h3,),
            ),
            ListTile(
              onTap: (){
                Get.back();
                Get.toNamed("/myproperties");
              },
              leading: Icon(Icons.list,size: 30,),
              title: AutoSizeText("My Properties",style: TextStyles.h3,),
            ),
            ListTile(
              leading: Icon(Icons.favorite,size: 30,color: Theme.of(context).primaryColor,),
              title: AutoSizeText("Favorite",style: TextStyles.h3,),
              onTap: (){
                Get.back();
                Get.to(()=>FavoritesView());
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_outlined,size: 30,),
              title: AutoSizeText("Payment",style: TextStyles.h3,),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet,size: 30,),
              title: AutoSizeText("How to pay?",style: TextStyles.h3,),
            ),
            Divider(thickness: 2,),
            ListTile(
              leading: Icon(Icons.share,size: 30,),
              title: AutoSizeText("Share",style: TextStyles.h3,),
            ),
            ListTile(
              leading: Icon(Icons.feedback,size: 30,),
              title: AutoSizeText("Feedback",style: TextStyles.h3,),
            ),
            ListTile(
              onTap: ()async{
                await Get.defaultDialog(title: "Logout",middleText: "Are you sure you want to logout?",
                  titleStyle: TextStyle(color: Colors.black),
                  cancel: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),onPressed: (){
                    Get.back();
                  },child: Text("No",style: TextStyle(color: Colors.white),),
                  ),confirm: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),onPressed: ()async{
                    await Get.find<FireBaseAuthService>().signOut();
                    Get.offAllNamed("/auth");
                  },child: Text("Yes",style: TextStyle(color: Colors.white),),
                  ),);
              },
              leading: Icon(Icons.logout_outlined,size: 30,),
              title: AutoSizeText("Logout",style: TextStyles.h3.copyWith(color: Theme.of(context).primaryColor),),
            ),
          ],
        ),
      ),
    );
  }
}
