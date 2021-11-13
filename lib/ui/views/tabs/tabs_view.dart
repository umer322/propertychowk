import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertychowk/ui/views/tabs/tabs_controller.dart';


class TabsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(builder: (controller){
      return Scaffold(
        body: WillPopScope(
          onWillPop: ()async{
            bool goBack=await controller.checkBackButtonFunctionality();
            return goBack;
          },
          child: IndexedStack(
            children: controller.views,
            index: controller.index,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: controller.changeTab,
          currentIndex: controller.index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.explore),label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.message_outlined),label: "Group Chat"),
          ],
        ),
      );
    });
  }
}
