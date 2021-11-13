class AppUser{
  String? id;
  String? name;
  String? email;
  String? imageUrl;
  bool? verified;
  String? phoneNumber;
  String? estateName;
  String? phoneNumberCountryCode;
  String? packageId;
  int? balance;
  String? deviceId;
  int? hotAdNumbers;
  int? superHotAdNumbers;
  DateTime? createdAt;
  List<String>? favorites;
  AppUser({this.favorites,this.name,this.deviceId,this.hotAdNumbers,this.superHotAdNumbers,this.balance,this.createdAt,this.packageId,this.estateName,this.email,this.id,this.imageUrl,this.verified,this.phoneNumber,this.phoneNumberCountryCode});
  factory AppUser.fromJson(Map<String,dynamic> data,String id){
    return AppUser(
      id: id,
      name: data['name'],
      email: data['email'],
      imageUrl: data['image'],
      estateName: data['estate_name'],
      phoneNumberCountryCode: data['phone_code'],
      verified:data['verified'],
      phoneNumber: data['phone_number'],
      packageId:data['package'] is Map?data['package']['id']:data['package'],
      deviceId: data['device_id'],
      hotAdNumbers: data['hot_ads']!=null?int.parse(data['hot_ads']?.toString()??'0'):0,
      superHotAdNumbers: data['superhot_ads']!=null?int.parse(data['superhot_ads']?.toString()??'0'):0,
      favorites: List<String>.from(data['favorites']??[]),
    );
  }
  toMap(){
    return {
      "name":name,
      "email":email,
      "image":imageUrl,
      "estate_name":estateName,
      "device_id":deviceId,
      "verified":verified,
      "hot_ads":hotAdNumbers??0,
      "superhot_ads":superHotAdNumbers??0,
      "phone_code":phoneNumberCountryCode,
      "phone_number":phoneNumber,
      "package":packageId,
      "favorites":favorites??[]
    };
  }
}