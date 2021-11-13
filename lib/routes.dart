import 'package:get/get.dart';
import 'package:propertychowk/models/property.dart';
import 'package:propertychowk/ui/views/addproperty/addproperty_controller.dart';
import 'package:propertychowk/ui/views/addproperty/addproperty_view.dart';
import 'package:propertychowk/ui/views/auth/auth_controller.dart';
import 'package:propertychowk/ui/views/auth/auth_view.dart';
import 'package:propertychowk/ui/views/myproperties/myproperties_controller.dart';
import 'package:propertychowk/ui/views/myproperties/myproperties_view.dart';
import 'package:propertychowk/ui/views/profile/profile_controller.dart';
import 'package:propertychowk/ui/views/profile/profile_view.dart';
import 'package:propertychowk/ui/views/splash/splash_view.dart';
import 'package:propertychowk/ui/views/tabs/tabs_controller.dart';
import 'package:propertychowk/ui/views/tabs/tabs_view.dart';
import 'package:propertychowk/ui/widgets/restricted.dart';

List<GetPage> routes=[
    GetPage(name: "/", page: ()=>SplashScreen()),
    GetPage(name: "/auth", page: ()=>AuthView(),binding: BindingsBuilder((){
        Get.put(AuthController());
    })),
    GetPage(name: "/tabs", page: ()=>TabsView(),binding: BindingsBuilder((){
        Get.put(TabsController());
    })),
    GetPage(name: "/addproperty", page: ()=>AddPropertyView(),binding: BindingsBuilder((){
        Get.put(AddPropertyController(Property()));
    })),
    GetPage(name: "/myproperties", page: ()=>MyPropertiesView(),binding: BindingsBuilder((){
        Get.put(MyPropertiesController());
    })),
    GetPage(name: "/profile", page: ()=>ProfileView(),binding: BindingsBuilder((){
        Get.put(ProfileController());
    })),
    GetPage(name: "/restricted", page: ()=>RestrictedView())
];