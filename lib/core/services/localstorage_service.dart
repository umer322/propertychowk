
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class LocalStorageService extends GetxService{
  Location location = new Location();
  final box = GetStorage();
  getCity()=>box.read("city");
  getSociety()=>box.read("society");

  setCity(String? name){
    box.write("city", name);
  }

  setCityFromLocation()async{

    bool _serviceEnabled= await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    PermissionStatus _permissionGranted= await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData _locationData = await location.getLocation();
   try{
     List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(_locationData.latitude!, _locationData.longitude!);
     geo.Placemark first = placemarks.first;
     if(first.locality!=null){
       box.write("location", first.locality);
     }
   }
   catch(e){
     print(e);
   }

  }

  getLocation(){
    return box.read("location");
  }

  setSociety(String? name){
    box.write("society", name);
  }


  @override
  void onInit() {

    setCityFromLocation();
    super.onInit();
  }
}