
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Property{
  String? id;
  String? city;
  String? propertyType;
  String? propertySubType;
  int? purpose;
  String? propertyArea;
  String? propertyPrice;
  String? areaType;
  String? propertyTitle;
  String? bedrooms;
  int? updatedCount;
  Uint8List? localPropertyThumbnail;
  String? society;
  String? phase;
  String? block;
  String? sector;
  double? calculatingArea;
  String? mohallah;
  String? road;
  String? floor;
  bool? featured;
  int? featureType;
  String? street;
  String? optionalNumber;
  String? propertyNumber;
  DateTime? date;
  String? bathrooms;
  List<String>? status;
  String? sellerId;
  List<String>? propertyFeatures;
  List<String>? propertyImages;
  String? propertyVideo;
  String? propertyVideoThumbnail;
  String? description;
  String? messageId;
  List<String>? favorites;
  String? sellerName;
  String? sellerNumber;
  String? remarks;
  Property({this.updatedCount,this.propertyTitle,this.localPropertyThumbnail,this.propertyVideoThumbnail,this.description,this.society,this.calculatingArea,this.propertyVideo,this.optionalNumber,this.featured,this.featureType,this.sellerName,this.sellerNumber,this.remarks,this.floor,this.status,this.street,this.road,this.mohallah,this.sector,this.messageId,this.favorites,this.propertyNumber,this.block,this.phase,this.bedrooms,this.date,this.id,this.sellerId,this.propertyType,this.propertyArea,this.purpose,this.areaType,this.bathrooms,this.city,this.propertyFeatures,this.propertyImages,this.propertyPrice,this.propertySubType});
  factory Property.fromJson(Map<String,dynamic> data,String id){
    return Property(
      id: id,
      city: data['city'],
      propertyType: data['property_type'],
      propertyVideo: data['property_video'],
      propertySubType: data['sub_type'],
      propertyTitle: data['property_title'],
      propertyNumber: data['property_number']??"",
      purpose: data['purpose'],
      updatedCount: data['updated_count']??3,
      propertyVideoThumbnail: data['property_video_thumbnail'],
      description: data['description'],
      propertyArea: data['area'],
      calculatingArea:double.parse(data['calculating_area'].toString()),
      featured: data['featured']??false,
      featureType: data['feature_type'],
      street:data['street'],
      remarks: data['remarks'],
      propertyPrice: data['price'],
      optionalNumber: data['optional_number'],
      floor: data['floor'],
      areaType: data['area_type'],
      messageId: data['message_id'],
      sector: data['sector'],
      mohallah: data['mohallah'],
      road: data['road'],
      sellerName: data['username'],
      sellerNumber: data['usernumber'],
      status: getFeaturesList(data['status']??[]),
      bedrooms: data['bedrooms'],
      bathrooms: data['bathrooms'],
      favorites: getFavoriteList(data['favorites']??[]),
      society: data['society'],
      phase: data['phase'],
      block: data['block']??"",
      date: DateTime.parse(data['date']),
      sellerId:data['seller_id'],
      propertyFeatures: getFeaturesList(data['property_features']??[]),
      propertyImages:getFeaturesList( data['images']??[])
    );
  }

  static List<String> getFeaturesList(List data){
    return data.map((e) => e.toString()).toList();
  }
  static List<String> getFavoriteList(List data){
    return data.map((e) => e.toString()).toList();
  }
  toMap(){
    return {
      "city":city,
      "property_type":propertyType,
      "sub_type":propertySubType,
      "purpose":purpose,
      'calculating_area':calculatingArea,
      "area":propertyArea,
      'remarks':remarks,
      "price":propertyPrice,
      "featured":featured,
      "feature_type":featureType,
      "status":status,
      'optional_number':optionalNumber,
      'property_video':propertyVideo,
      'updated_count':updatedCount,
      "area_type":areaType,
      "bedrooms":bedrooms,
      "floor":floor,
      'property_video_thumbnail':propertyVideoThumbnail,
      "property_number":propertyNumber,
      "bathrooms":bathrooms,
      "society":society,
      "phase":phase,
      "street":street,
      "sector":sector,
      "mohallah":mohallah,
      "road":road,
      "favorites":favorites,
      "block":block,
      'property_title':propertyTitle,
      "seller_id":sellerId,
      "message_id":messageId,
      'description':description,
      "property_features":propertyFeatures,
      "images":propertyImages,
      "date":date?.toIso8601String()
    };
  }

  static String buildPrice(String val){
    if(val.length==4){
      return "${int.parse(val.substring(0,1))} Thousand";
    }
    else if(val.length==5){
      return "${int.parse(val.substring(0,2))} Thousand";
    }
    else if(val.length==6){
      return "${int.parse(val.substring(0,1))}${val.substring(1,3)!="00"?("."+int.parse(val.substring(1,3)).toString()):""} Lakh";

    }
    else if(val.length==7){

      return "${ int.parse(val.substring(0,2))}${val.substring(2,4)!="00"?"."+int.parse(val.substring(2,4)).toString():""} Lakh";
    }
    else if(val.length==8){
      return "${int.parse(val.substring(0,1))}${val.substring(1,3)!="00"?"."+int.parse(val.substring(1,3)).toString():""} Crore";
    }
    else if(val.length==9){
      return "${int.parse(val.substring(0,2))}${val.substring(2,4)!="00"?"."+int.parse(val.substring(2,4)).toString():""} Crore";
    }
    else if(val.length==10){
      return "${int.parse(val.substring(0,1))}${val.substring(1,3)!="00"?"."+int.parse(val.substring(1,3)).toString():""} Arab";
    }
    else if(val.length==11){
      return "${int.parse(val.substring(0,2))}${val.substring(2,4)!="00"?"."+int.parse(val.substring(2,4)).toString():""} Arab";
    }
    else{
      return val;
    }
  }


  static List<Map> propertyTypes =[
    {
      "name":"Plot",
      "icon":"assets/agricultural_land.png",
    },
    {
      "name":"Home",
      "icon":FontAwesomeIcons.home
    },
    {
      "name":"Commercial",
      "icon":"assets/commercial_plot.jpg"
    },
    {
      "name":"Farm House",
      "icon":FontAwesomeIcons.hotel
    }
  ];

  static List<Map> homePropertyTypes=[
    {
      "name":"House",
      "icon":FontAwesomeIcons.home,
    },
    {
      "name":"Flat",
      "icon":FontAwesomeIcons.building
    },
    {
      "name":"Room",
      "icon":FontAwesomeIcons.doorClosed
    },
    {
      "name":"Penthouse",
      "icon":FontAwesomeIcons.hotel
    }
  ];


  static List<Map> plotsPropertyTypes=[
    {
      "name":"Residential",
      "icon":"assets/residential_plot.png"
    },
    {
      "name":"Commercial",
      "icon":"assets/commercial_plot.jpg"
    },
    {
      "name":"Agricultural",
      "icon":"assets/agricultural_land.png"
    },
    {
      "name":"Industrial",
      "icon":"assets/industrial_plot.png"
    },
    {
      "name":"File",
      "icon":FontAwesomeIcons.file
    },
    {
      "name":"Plot Form",
      "icon":FontAwesomeIcons.wpforms
    }
  ];
  static List<Map> commercialPropertyType=[
    {
      "name":"Office",
      "icon":FontAwesomeIcons.building
    },
    {
      "name":"Shop",
      "icon":FontAwesomeIcons.shopify
    },
    {
      "name":"Warehouse",
      "icon":FontAwesomeIcons.warehouse
    },
    {
      "name":"Factory",
      "icon":FontAwesomeIcons.industry
    },
    {
      "name":"Building",
      "icon":Icons.domain
    },];
  static List<Map> farmHouseTypes=[
    {
      "name":"Farm House",
      "icon":FontAwesomeIcons.hotel
    }
  ];

  static getCalculatingArea(String areaType,String propertyArea){
    if(areaType=="Sq.ft"){
      return double.parse(propertyArea.toString());
    }
    else if(areaType=="Yards"){
      return double.parse((double.parse(propertyArea.toString())*9).toStringAsFixed(1));
    }
    else if(areaType=="Marla"){
      return double.parse((double.parse(propertyArea.toString())*225).toStringAsFixed(1));
    }
    else if(areaType=="Kanal"){
      return double.parse((double.parse(propertyArea.toString())*4500).toStringAsFixed(1));
    }
    else if(areaType=="Acre"){
      return double.parse((double.parse(propertyArea.toString())*43560).toStringAsFixed(1));
    }
  }

  static List<String>  popularCities=["Islamabad","Karachi","Lahore","Rawalpindi"];

  static List<String>  cities = ["Abbottabad","Abdul Hakim","Ahmedpur East","Alipur","Arifwala","Astore","Attock","Awaran","Badin","Bagh","Bahawalnagar","Bahawalpur","Balakot","Bannu","Barnala","Batkhela","Bhakkar","Bhalwal","Bhimber","Buner","Burewala","Chaghi","Chakwal","Charsadda","Chichawatni","Chiniot","Chistian Sharif","Chitral","Choa Saidan Shah","Chunian","Dadu","Daharki","Daska","Daur","Depalpur","Dera Ghazi Khan","Dera Ismail Khan","Dijkot","Dina","Dobian","Duniya Pur","Faislabad","FATA","Fateh Jang","Fort Abbas","Gaarho","Gadoon","Galyat","Ghakhar","Gharo","Ghotki","Gilgit","Gojra","Gujar Khan","Gujranwala","Gujrat","Gwadar","Hafizabad","Hala","Hangu","Harappa","Haripur","Haroonabad","Hasilpur","Hassan Abdal","Haveli Lakha","Hazro","Hub Chowki","Hujra Shah Muqeem","Hunza","Hyderabad","Jacobabad","Jahanian","Jalalpur Jattan","Jampur","Jamshoro","Jatoi","Jauharabad","Jhang","Jhelum","Kaghan","Kahror Pakka","Kalat","Kamalia","Kamoki",'Kahna Canal View',"Kandiaro","Karak","Kasur","Khairpur","Khanewal","Khanpur","Kharian","Khipro","Khushab","Khuzdar","Kohat","Kot Addu","Kotli","Kotri","Lakki Marwat","Lalamusa","Larkana","Lasbela","Layyah","Liaqatpur","Lodhran","Loralai","Lower Dir","Mailsi","Makran",'Madina Garden',"Malakand","Mandi Bahauddin","Mangla","Mansehra","Mardan","Matiari","Matli","Mian Channu","Mianwali","Mingora","Mirpur","Mirpur Khas","Mirpur Sakro","Mitha Tiwana","Moro","Multan","Muridke","Murree","Muzaffarabad","Muzaffargarh","Nankana Sahib","Naran","Narowal","Nasar Ullah Khan Town","Nasirabad","Naushahro Feroze","Nawabshah","Neelum","New Mirpur City","Nowshera","Okara","Others","Others Azad Kashmir","Others Balochistan","Others Gilgit Baltistan","Others Khyber Pakhtunkhwa","Others Punjab","Others Sindh","Pakpattan","Peshawar","Pind Dadan Khan","Pindi Bhattian","Pir Mahal","Qazi Ahmed","Quetta","Rahim Yar Khan","Rajana","Rajanpur","Ratwal","Rawalakot","Rohri","Sadiqabad","Sahiwal","Sakrand","Samundri","Sanghar","Sangla Hill","Sarai Alamgir","Sargodha","Sehwan","Shabqadar","Shahdadpur","Shahkot","Shahpur Chakar","Shakargarh","Shehr Sultan","Sheikhupura","Sher Garh","Shikarpur","Shorkot","Sialkot","Sibi","Skardu","Sudhnoti","Sujawal","Sukkur","Swabi","Swat","Talagang","Tando Adam","Tando Allahyar","Tando Bago","Tando Muhammad Khan","Taxila","Tharparkar","Thatta","Toba Tek Singh","Turbat","Vehari","Wah","Wazirabad","Waziristan","Yazman","Zhob"];

  static List<String> lahoreSocieties=['Abbot Road','Al-Hadi Garden','Al-Hamra City','Allama Iqbal Intl Airport','Allama Iqbal Town','Al-Noor Park Housing Society','Army Housing Society','Ashrafi Town','Atomic Energy Society - PAEC','Avicenna City','AR Cottages', 'Aabpara Coop Housing Society', 'Aashiana Road', 'Abdali Road', 'Abdalians Cooperative Housing Society', 'Abdul Sattar Edhi Road', 'Abdullah Town', 'Abid Road', 'Abuzar Housing Scheme', 'Adan Villas', 'Aftab Garden', 'Afzal Park', 'Agrics Town', 'Ahbab Colony', 'Ahbab Housing Society', 'Ahlu Road', 'Ahmad Avenue', 'Ahmad Housing Society', 'Ahmed Colony', 'Ahsan Park Housing Scheme', 'Airline Housing Society', 'Airport Road', 'Aitchison Society', 'Al Faisal Town', 'Al Fajar Society', 'Al Hafeez Gardens', 'Al Hamad Colony', 'Al Hamra Town', 'Al Haram Garden', 'Al Jalil Garden', 'Al Jannat Housing Scheme', 'Al Kareem Garden', 'Al Madina Avenue', 'Al Noor Town', 'Al Raheem Town', 'Al Rahim Homes', 'Al Rehman Garden', 'Al-Amin Housing Society', 'Al-Falah Cooperative Housing Society', 'Al-Hafeez Garden Road', 'Al-Hafiz Town', 'Al-Hamad Colony (AIT)', 'Al-Hamd Garden', 'Al-Hamd Park', 'Al-Jannat Housing Society - Kahna', 'Al-Kareem Premier Housing Scheme', 'Al-Qayyum Garden', 'Al-Raheem Garden', 'Al-Raziq Garden', 'Al-Wahab Garden - Phase 1', 'Alfalah Town', 'Ali Alam Garden', 'Ali Town', 'Ali View Garden', 'Ali View Park', 'Alia Town', 'Allama Iqbal Road', 'Iqbal Town', 'Altaf Colony', 'Aman Town', 'Ameen Park', 'Ameer-ud-Din Park', 'Amina Park', 'Anarkali', 'Angoori Bagh', 'Angori Scheme 1', 'Architects Engineers Housing Society', 'Arya Nagar', 'Ashiana-e-Quaid Housing Scheme', 'Ashraf Garden', 'Asif Colony', 'Asif Town', 'Asim Town', 'Askari', 'Atari Saroba', 'Audit & Accounts Housing Society', 'Awan Town', 'Azadi Chowk', 'Azam Cloth Market', 'Azam Gardens', 'Azeem Garden Shahdara', 'Azizia Town', 'BOR - Board of Revenue Housing Society', 'BRB Canal Road', 'Babu Sabu', 'Badami Bagh', 'Bagarian', 'Bagh Gul Begum','Bagh-e-Iram Housing Society','Bahadurabad','Bhasin','Budduke Manak Road','', 'Baghbanpura', 'Bahar Colony', 'Bahar Shah Road', 'Bahawalpur Road', 'Bahria Education & Medical City', 'Bahria Nasheman', 'Bahria Orchard', 'Bahria Town', 'Bakhsh Town', 'Band Road', 'Bandian Wala', 'Bankers Avenue Cooperative Housing Society', 'Bankers Co-operative Housing Society', 'Bankers Town', 'Batapur', 'Beacon House Society', 'Beadon Road', 'Bedian Road', 'Begampura', 'Begum Kot', 'Bhagatpura', 'Bhaini Road', 'Bhatta Chowk', 'Bhatti Colony', 'Bhogiwal', 'Bhogiwal Road', 'Bilal Gunj', 'Birdwood Road', 'Bismillah Housing Scheme', 'Blue Town', 'Brandreth Road', 'Burj Attari', 'Canal Bank Housing Scheme', 'Canal Burg', 'Canal Fort II', 'Christian Colony','City Garden','Canal Garden', 'Canal View', 'Canalberg Housing Society', 'Cantt', 'Cantt View Society', 'Captain Jamal Road', 'Cavalry Extension', 'Cavalry Ground', 'Central Park Housing Scheme', 'Chah Miran', 'Chaman Park', 'Charrar', 'Chauburji', 'Chauburji Chowk', 'Chauburji Park Road', 'Chaudhary Colony', 'China Scheme', 'Chinar Bagh', 'Chinar Court', 'Chohan Road', 'Chungi Amar Sadhu', 'Circular Road', 'Civil Defence', 'Clifton Colony', 'College Road', 'Combo Colony', 'Cooper Road', 'Cricketer Villas', 'DHA', 'DHA City','DHA Rahbar', 'Daroghewala', 'Dars Baray Mian', 'Data Darbar Road', 'Davis Road', 'Defence Fort', 'Defence Road', 'Dharampura', 'Dholanwal', 'Dilkusha Gardens', 'Divine Gardens', 'Divine Homes', 'Doctors Housing Society', 'Dogech', 'Dream Avenue Lahore', 'Dream Villas', 'Dubai Town', 'Dubban Pura', 'Durand Road', 'Egerton Road','Evergreen Housing Scheme','EME Society', 'Eden', 'Eden Avenue Extension', 'Eden Park', 'Eden Villas', 'Education Town', 'Elite Town', 'Empress Road', 'Excise & Taxation Housing Scheme', 'Expo Avenue Society', 'Faisal Town', 'Faiz Bagh', 'Fane Road', 'Farid Court Road', 'Farooq Colony', 'Fateh Garh','Ferozepur City','Fateh Villas', 'Fatehabad', 'Fazaia Housing Scheme', 'Ferozepur Road', 'Ferozewala', 'Firdous Colony', 'Formanites Housing Scheme', 'Fort Villas', 'GCP Housing Scheme','Government Superior Services' ,'GOR', 'GT Road', 'Gaddafi Stadium', 'Gajju Matah','Govt Officers Cooperative Housing Society','Gul Colony','', 'Garden Town', 'Garhi Shahu', 'Garrison Homes', 'Gawalmandi', 'Ghalib Market', 'Ghausia Colony', 'Ghawind', 'Ghaziabad', 'Ghous Garden', 'Gohawa', 'Gold Land Garden', 'Gosha-e-Ahbab', 'Govt. Employees Cooperative Housing Society (GECHS)', 'Govt. Transport Headquarters Cooperative Housing Society', 'Grand Avenues Housing Scheme', 'Green Acres Housing Society', 'Green Cap Housing Society', 'Green City', 'Green Fort', 'Green Park Society', 'Green Town Sector D2', 'Gujjar Colony', 'Gujjarpura', 'Ghory Shah', 'Gul-e-Damin', 'Gulbahar Colony', 'Gulbahar Park', 'Gulberg', 'Guldasht Town', 'Gulfishan Colony', 'Gulfishan Town', 'Gulnishan Park', 'Gulshan Colony', 'Gulshan Farooq Scheme', 'Gulshan Park', 'Gulshan-E-Haider Housing Society', 'Gulshan-E-Mustafa Housing Society', 'Gulshan-e-Ahbab', 'Gulshan-e-Lahore', 'Gulshan-e-Rail', 'Gulshan-e-Ravi', 'Gulshan-e-Shalimar Housing Scheme', 'Gulshan-e-Yaseen Housing Society', 'Gulzar E Ahbab Society', 'Gurumangat', 'HBFC Housing Society', 'Habib Homes', 'Habibullah Road', 'Haji Park Housing Scheme', 'Hajvery Housing Scheme', 'Hakim Town', 'Hall Road', 'Hameedpura', 'Hamza Town', 'Hanif Park Harbanspura','Hamdan Life Society','Gulshan-e-Sardar Housing Scheme','Hayderabad','Hidayatabad', 'Hanjarwal', 'Harbanspura', 'Hassan Town', 'Heaven Homes', 'Heir', 'Highcourt Society', 'Hudiara', 'IBL Housing Scheme', 'IEP Engineers Town', 'Ichhra','Ibrahim Colony','International City Country Homes', 'Ideal Homes', 'Immad Garden Housing Scheme', 'Infantry Road', 'Inmol Society', 'Iqbal Avenue', 'Iqbal Park', 'Irrigation Cooperative Housing Society', 'Irum Garden Housing Society', 'Islam Nagar', 'Islamabad Colony', 'Islamia Park', 'Islampura', 'Ismail Town', 'Ittehad Colony', 'Ittehad Park', 'Ittifaq Town', 'Izmir Town', 'Jaffar Town', 'Jaffaria Colony', 'Jail Road', 'Jalal Colony', 'Jallo', 'Jameel Park', 'Jamil Town', 'Jan Muhammad Road', 'Jaranwala Road', 'Jati Umra Road', 'Javed Colony - Ghazi Road','Jaranwala Road(10)','Javed Park', 'Jia Baga Road', 'Jinnah Colony', 'Jinnah Park', 'Johar Town', 'Jora Pull', 'Jubilee Town', 'Judicial Colony', 'KEMC Housing Society', 'Kacha Ferozepur Road', 'Kacha Jail Road','Kacha Road','Kala Khatai Road','Khaira Distributary','Khaira', 'Kacha Lawrence Road', 'Kahna', 'Kahna Kacha', 'Kakezai Housing Society', 'Kalma Chowk', 'Kamahan Road', 'Karbath', 'Kardar Park', 'Karim Park', 'Kashmir Road', 'Katar Bund Road', 'Kausar Colony', 'Keer Khurd', 'Khaliq Nagar', 'Khana Kacha Road', 'Kharak', 'Khawaja Ahmed Hassan Road', 'Khayaban-e-Amin', 'Khayaban-e-Jinnah Road', 'Khayaban-e-Quaid', 'Khayaban-e-Zohra', 'Khokhar Town', 'Kot Araian', 'Kot Khawaja Saeed', 'Kot Lakhpat', 'Kotli Abdur Rahman', 'Krishan Nagar', 'LDA Avenue', 'LDA Road', 'Labor Colony', 'Lahore - Islamabad Motorway', 'Lahore - Jaranwala Road', 'Lahore Kasur Road', 'Lahore Garden Housing Scheme', 'Lahore Medical Housing Society', 'Lahore - Kasur Road','Lahore Avenue','Lahore Canal Bank Cooperative Housing Society','Lahore Motorway City', 'Lahore Press Club Housing Scheme', 'Lahore Railway Station Road', 'Lahore Villas', 'Lakhodher', 'Lakshmi Chowk', 'Lalazaar Garden', 'Land Breeze Housing Society', 'Landa Bazaar', 'Lawrence Road', 'Liaquatabad', 'Lower Mall', 'Lytton Road', 'Madar-e-Millat Road', 'Malik Irfan Garden','Malipura','Manga - Raiwind Road','MET 1','Mid City','Millat Tractors Employees Housing Society','Model Housing Scheme','Mohlanwal','Madina Colony', 'Madina Homes', 'Madina Town', 'Main Canal Bank Road', 'Makkah Colony', 'Makki Complex', 'Malik Park', 'Mall Road', 'Manawan', 'Manga Mandi', 'Manhala Road', 'Mansoora Homes', 'Mansoorah', 'Manzoor Colony', 'Marghzar Officers Colony', 'Mason Road', 'Mateen Avenue', 'Maulana Shaukat Ali Road', 'Mayo Hospital Road', 'McLeod Road', 'Medical Town', 'Mehar Fayaz Colony', 'Meharpura', 'Mehmood Booti', 'Mehmood Colony', 'Mehrabad', 'Mian Amiruddin Park', 'Mian Aziz Garden', 'Mian Colony', 'Mian Mir Colony', 'Military Accounts Housing Society', 'Millat Road', 'Misri Shah', 'Model Colony', 'Model Town', 'Mohafiz Town', 'Mohlanwal Road', 'Mohlanwal Scheme', 'Mohni Road', 'Mominpur', 'Mominpura Road', 'Moon Colony', 'Mozang', 'Mubarak Town', 'Mughalpura', 'Multan Road', 'Munir Garden', 'Muqaddas Park', 'Mushtaq Colony', 'Muslim Nagar Housing Scheme', 'Muslim Town', 'Mustafa Abad', 'Mustafa Town', 'NFC 1', 'Nabi Pura', 'Nadeem Shaheed Road', 'Nadeem Town', 'Nadia Ghee Mill Chowk', 'Nai Abadi Harbanspura', 'Nain Sukh', 'Nasheman-e-Iqbal', 'Nasirabad', 'National Town', 'Nawab Town','National Bank Cooperative Housing Society','Naval Anchorage','New Bilal Ganj Industrial Scheme','New Kashmir Park Housing Scheme','New Samanabad','NFC 2', 'Nawaz Sharif Colony', 'Naz Town', 'Nazir Garden Society', 'New Amir Town', 'New Canal Park', 'New Chauburji Park', 'Garden Town', 'New Khan Colony', 'New Muslim Town', 'New Shah Kamal Colony', 'New Super Town', 'Nicholson Road', 'Nisbat Road', 'Nishat Colony', 'Nishtar Colony', 'Nizamabad', 'Nobel Town (KCHS)', 'Noor Jahan Road', 'OPF Housing Scheme', 'Officer Colony','Olympians Cooperative Housing Society','Omega Homes' ,'Okaf Colony', 'Outfall Road', 'P & D Housing Society', 'PAF Colony', 'PAF Society','Pajian Manik Road','Pakistan Medical Housing Society','Pandoke','Paradise Homes Super Town','Park Avenue Housing Scheme','Park View City','Punjab Government Servant Housing Foundation', 'PASSCO Housing Society', 'PCSIR Housing Scheme', 'PCSIR Staff Colony', 'PIA Housing Scheme', 'PIA Main Boulevard', 'Pak Arab Housing Society', 'Pak Park', 'Pakki Thatti', 'Palm Villas', 'Paragon City', 'Park View Villas', 'Peco Road', 'Peer Colony', 'Pine Avenue', 'Pine Villas', 'Pir Naseer', 'Poonch Road', 'Prem Nagar', 'Prime Homes 1', 'Public Health Society', 'Punjab Coop Housing Society', 'Punjab Govt Employees Society', 'Punjab Govt Servant Society', 'Punjab Small Industries Colony', 'Punjab University Employees Society', 'Qadri Colony', 'Qartaba Chowk', 'Qasurpura', 'Qazi Town', 'Qilla Gujjar Singh', 'Quaid-e-Azam Industrial Estate', 'Qasim Garden','Queens Road', 'Rail Town (Canal City)', 'Rajgarh Road','Rehmanpura','River Edge Housing Scheme','Raiwind Road', 'Raj Garh', 'Rajpoot Town', 'Rana Shaukat Mehmood Road', 'Rana Town', 'Rang Mahal', 'Rasool Park', 'Ravi Road', 'Real Cottages', 'Rehan Garden', 'Rehman City - Phase 4', 'Rehman City Phase 6', 'Rehman Gardens', 'Rehman Villas', 'Rehmat Colony', 'Revenue Society', 'Rewaz Garden', 'Rifle Range Road', 'Ring Road', 'River View Coop Housing Society', 'Riwaz Garden', 'Rizwan Garden Scheme', 'Rohi Nala Road', 'Royal Garden', 'Royal Residencia', 'Rustam Park', 'Saadi Park', 'Sabzazar Scheme', 'Sadaat Town', 'Sadat Cooperative Housing Society (College Town)', 'Safari Garden Housing Scheme', 'Saggian', 'Sadhoke','Sanda Road','Saraich','Shah Alam Market','Shoukat Town','Sue-e-Asal Road','Sui Northern Gas Society','Sundar Industrial Estate','Sundar Small Industrial Estate 2','','Saggian Wala Bypass Road', 'Sahafi Colony', 'Saiden Shah Colony', 'Saidpur', 'Sajid Garden', 'Salamatpura', 'Salli Town', 'Samanabad', 'Samanzar Colony', 'Sami Town', 'Samsani Road', 'Sanda', 'Sant Nagar', 'Saqib Town', 'Saroba Gardens Housing Society', 'Sarwar Town', 'Shabbir Town', 'Shadab Garden', 'Shadbagh', 'Shadipura', 'Shadman', 'Shadman Enclave', 'Shah Alam', 'Shah Faisal Road', 'Shah Jamal', 'Shah Kamal Road', 'Shah Khawar Town', 'Shahdara', 'Shaheen Park', 'Shahpur Kanjra', 'Shahtaj Colony', 'Shalimar Housing Scheme', 'Shalimar Link Road', 'Shalimar Town', 'Sham Nagar', 'Shama Road', 'Shams Colony', 'Shanghai Road', 'Sharaqpur Road', 'Shaukat Khanum Road', 'Sheikhupura Road', 'Sher Ali Road', 'Sher Shah Road', 'Shera Kot', 'Sheraz Town', 'Shershah Colony - Ichra', 'Shershah Colony - Raiwind Road', 'Sherwani Town Housing Scheme', 'Shiraz Villas', 'Shoukat Town', 'Shuja Road', 'Siddiqia Colony', 'Siddiqia Society (College Road)', 'Singhpura', 'Sitara Colony', 'Sodiwal', 'Sozo Town', 'State Life Housing Society', 'Sue-e-Asal', 'Sufiabad', 'Sui Gas Employees Cooperative Housing Society', 'Sui Gas Housing Society', 'Sukh Chayn Gardens', 'Sultan Park', 'Sultan Pura', 'Sultan Town', 'Sundar', 'Sundar Road', 'Sunflower Housing Society', 'Sunfort Gardens', 'Sunny Park', 'Super Town', 'Supreme Villas', 'Samanabad', 'Swami Nagar', 'T & T Aabpara Housing Society', 'TECH Society', 'TIP Housing Society', 'Taj Bagh Scheme', 'Tajpura', 'Tariq Colony', 'Tariq Gardens', 'Tariq Ismail Road', 'Temple Road', 'Tezab Ahata Road','Tarogill', 'Thethar', 'Thokar Niaz Baig', 'Timber Market Scheme', 'Toheed Park', 'Township', 'Tricon Village', 'Tulspura', 'UBL Housing Society','UMT Society','Urban Canal City', 'UET Housing Society', 'Umer Colony', 'Upper Mall', 'Urdu Bazar', 'Usmania Colony', 'Valencia Housing Society', 'Venus Housing Scheme', 'Vital Homes Housing Scheme','Victoria Park','Wapda Farm Housing Society','Wapda Finance Officers Cooperative Housing Society', 'Wafaqi Colony', 'Wagha Town', 'Wahdat Colony', 'Wahdat Road', 'Waheed Brother Colony', 'Wahga', 'Walled City', 'Walton Railway Officers Colony', 'Walton Road', 'Wapda Town', 'Waris Colony', 'Waris Road', 'Wassan Pura Scheme No. 2', 'Wassanpura', 'West Wood Housing Society', 'Wyeth Employees Coop Housing', 'Yasrab Colony', 'Yazdani Road', 'Youhanabad', 'Zaheer Villas', 'Zaitoon - New Lahore City', 'Zaman Colony', 'Zaman Park','Zam Zam City', 'Zubaida Park','Others'];
  static List<String> islamabadSocieties=['7th Avenue', '9th Avenue', 'AGHOSH', 'Abdullah Garden', 'Agro Farming Scheme', 'Airline Avenue', 'Airport Avenue Housing Society', 'Airport Enclave', 'Aiza Garden', 'Al Huda Town', 'Al Qaim Town', 'Ali Pur', 'Alipur Farash', 'Angoori Road', 'Arsalan Town', 'Axis Mall & Apartments', 'B-17', 'Bahria Town', 'Bani Gala', 'Bhara kahu', 'Blue Area', 'Bokra Road', 'Burma Town', 'C-17', 'C-18', 'C-19', 'CBR Town', 'Capital Enclave', 'Chak Shahzad', 'Chatha Bakhtawar', 'Chattar', 'Chirah', 'Club Road', 'Commoners Sky Gardens', 'Constitution Avenue', 'D-12', 'D-14', 'D-16', 'D-17', 'DHA', 'Diplomatic Enclave', 'E-10', 'E-11', 'E-14', 'E-16', 'I-10', 'I-11', 'I-12', 'I-13', 'I-14', 'I-16', 'I-8', 'I-9', 'IJP Road', 'Ibn-e-Sina Road', 'Iqbal Town', 'Islamabad - Murree Expressway', 'Islamabad - Peshawar Motorway', 'Islamabad Enclave', 'Islamabad Expressway', 'Islamabad Highway', 'Ittefaq Town', 'J and K Zone 5', 'Jagiot Road', 'Japan Road', 'Jeddah Town', 'Jhang Syedan', 'Jhangi Syedan', 'Jinnah Avenue', 'Judicial Town', 'Kahuta Road', 'Karakoram Diplomatic Enclave', 'Kashmir Highway', 'Kashmir Town', 'Khanna Pul', 'Koral Chowk', 'Koral Town', 'Korang Road', 'Korang Town', 'Kuri', 'Kuri Road', 'Lawyers Society', 'Lehtarar Road', 'Madina Town', 'Main Margalla Road', 'Margalla Town', 'Margalla Valley - C-12', 'Marwa Town', 'Meherban Colony', 'Model Town', 'Mohra Nur Road', 'Motorway Chowk', 'Tarlai', 'Tarnol', 'Thalian', 'Thanda Pani', 'The Organic Farms Islamabad', 'The Springs', 'Top City 1', 'Tumair', 'University Town', 'Victoria Heights', 'Zaraj Housing Scheme', 'Zero Point', 'Zone 5', 'E-17', 'E-18', 'E-7', 'Eden Life Islamabad', 'Emaar Canyon Views', 'Engineering Co-operative Housing (ECHS)', 'F-10', 'F-11', 'F-14', 'F-15', 'F-17', 'F-6', 'F-7', 'F-8', 'FECHS', 'FOECHS - Foreign Office Employees Society', 'Faisal Town - F-18', 'Fateh Jang Road(11)', 'Federal Government Employees Housing Foundation', 'Frash Town', 'G-10', 'G-11', 'G-12', 'G-13', 'G-14', 'G-15', 'G-16', 'G-17', 'G-5', 'G-6', 'G-7', 'G-8', 'G-9', 'GT Road', 'Garden Town', 'Ghauri Town', 'Golra Mor', 'Golra Road', 'Green Avenue', 'Green Hills Housing Scheme', 'Gulberg', 'Gulshan-e-Khudadad', 'H-12', 'H-13', 'H-15', 'Multi Residencia & Orchards', 'Mumtaz City', 'Murree Road', 'NIH Colony', 'National Police Foundation', 'National Police Foundation O-9', 'Naval Anchorage', 'Naval Farms Housing Scheme', 'Naval Housing Scheme', 'New Airport Town', 'New Icon City', 'New Shakrial', 'Orchard Scheme', 'PAEC Employees Cooperative Housing Society', 'PAF Tarnol', 'PECHS', 'PTV Colony', 'PWD Housing Scheme', 'PWD Road', 'Pakistan Town', 'Park Enclave', 'Park Road', 'Park View City', 'Partal Town', 'Pindorian', 'Pir Sohawa', 'Police Foundation Housing Society', 'Qutbal Town', 'Rawal Enclave', 'Rawal Town', 'River Garden', 'Royal Avenue', 'Royal City', 'Sangjani', 'Sarai Kharbuza', 'Shah Allah Ditta', 'Shah Dara', 'Shaheen Town', 'Shahpur', 'Shehzad Town', 'Sihala', 'Simly Dam Road', 'Soan Garden', 'Sohan Valley', 'Spring Valley', 'Swan Garden', 'Taramrri','Others'];
  static List<String> gujranwalaSocieties=['Abadi Haji Ghulam Hassan', 'Abdullah Colony', 'Abid Colony', 'Al Mujeeb Town', 'Alam Chowk', 'Ali Pur Chatta', 'Allama Iqbal Town', 'Asad Colony', 'Asghar Colony', 'Attawa', 'Aziza Housing Scheme', 'Baghbanpura', 'Bakhtey Wala', 'Behari Colony', 'Bhekopur', 'Canal View Housing Scheme', 'Canal View Road', 'Chak Jagna', 'Chan Da Qila', 'Chicherwali', 'Citi Housing Society', 'Civil Lines', 'College Road', 'DC Colony', 'DC Road', 'Dhule', 'Ehtisham Colony', 'Eminabad More', 'Eminabad Road', 'Faisal Colony', 'Faiz Alam Town', 'Farid Town', 'Fazal Town', 'Ferozwala Road', 'G Magnolia Park', 'GT Road', 'Garden Town', 'Ghulam Mohammad Town', 'Gill Road', 'Gondla Wala Road', 'Green Town', 'Gujranwala Bypass', 'Gulshan Colony', 'Gulshan Iqbal Park', 'Gulzar Colony', 'Gurjakh', 'Raj Kot', 'Rana Colony', 'Rasheed Colony', 'Rasoolpura', 'Ratta Bajwa', 'Ratta Road', 'Sadiq Colony', 'Salam Colony', 'Samanabad', 'Sardar Colony', 'Sardar Town', 'Sarfraz Colony', 'Satellite Town', 'Shadman Town', 'Shaheen Abad', 'Shalimar Town', 'Sheikhupura Road', 'Sialkot Bypass', 'Sialkot Road', 'Siddique Colony', 'Siddque Akber Town', 'Sui Gas Road', 'Talwandi Musa Khan', 'Usman Colony', 'Wafi Citi Housing Scheme', 'Wahdat Colony', 'Waniawala', 'Wapda Town', 'Gurjakh Road', 'Guru Nanak Pura', 'Hafizabad Road', 'Haider Colony', 'Islam Pura', 'Ittihad Colony', 'Jalil Town', 'Jinnah Colony', 'Jinnah Road', 'Johar Town', 'Judicial Housing Colony', 'Kangniwala', 'Katchi Fatto Mand', 'Khalid Colony', 'Khiali', 'Khiali Shahpura', 'Khokhar Ke', 'Kot Ishaq', 'Krishan Nagar', 'Lohianwala', 'Madina Colony', 'Master City Housing Scheme', 'Mehar Colony', 'Merajpura', 'Moaifiwala', 'Model Town', 'Mohalla Faisalabad', 'Mohalla Mubarik Shab', 'Mominabad A', 'Muhafiz Town', 'Mumtaz Colony', 'Muslim Road', 'Muslim Town', 'Nomania Road', 'Noor Bawa', 'Nowshera Road', 'Nowshera Sansi Road', 'Others', 'Palm City Housing Scheme', 'Pasban Colony', 'Pasrur Road', 'Peoples Colony', 'Popular Nursery Town', 'Qila Didar Singh', 'Quaid-e-Azam Town', 'Rahwali Cantt','Others'];
  static List<String> multanSocieties=['Abbas Pur', 'Abbaspura', 'Abdali Road', 'Air Force Officers Housing Scheme', 'Airport Road', 'Akbar Road', 'Al Mustafa Colony', 'Al Mustafa Road', 'Al Quresh Housing Scheme', 'Al Raheem Colony', 'Ali Town', 'Altaf Town', 'Ansar Colony', 'Askari Bypass', 'Askari Colony', 'BZU Employers Colony', 'BZU Road', 'Baba Safra Road', 'Babar Road', 'Badla Town', 'Bahadurpur', 'Bahawalpur Road', 'Bahawalpur Sukha Road', 'Band Bosan', 'Basti Allah Bakhsh', 'Basti Malook', 'Basti Nau', 'Bhutta Colony', 'Bilal Chowk', 'Bodla Town', 'Bosan Road', 'Buch Executive Villas', 'Bukhari Colony', 'Canal Bank Road', 'Canal Cantt View Housing Society', 'Canal Cantt Villas', 'Canal Road', 'Cantt', 'Cantt Avenue', 'Chah Boharwala', 'Chah Daad Wala', 'Chowk Khuni Burj', 'Chowk Kumharanwala', 'Chowk Nagshah', 'Chungi No 1', 'Haideria Road', 'Haiderpura', 'Haram Gate', 'Hassanabad Colony', 'Hazoori Bagh Road', 'Hussain Agahi Bazar', 'Ibrahim Town', 'Income Tax Officers Colony', 'Industrial Estate', 'Ismailabad', 'Jahangirabad', 'Jail Road', 'Jalalpur Pirwala', 'Jalilabad', 'Jamilabad', 'Jamilabad Housing Scheme', 'Jamilabad Road', 'Jan Mohammad Colony', 'Jinnah Town', 'Johar Town', 'Justic Hamid Colony', 'Kacheri Road', 'Katchery Chowk', 'Khan Colony', 'Khan Village', 'Khan Village II', 'Khanewal Road', 'Khayaban-e-Kubra', 'Liaquatabad', 'Lodhi Colony', 'Lodhi Colony Road', 'Lodhran Road', 'Lohari Gate Multan', 'Lutafabad', 'MA Jinnah Road', 'MDA Chowk', 'MDA Co-operative Housing Scheme', 'MDA Road', 'Madina Town', 'Manzoorabad', 'Masoom Shah Road', 'Mattital Road', 'Meherban Colony', 'Metro Plaza', 'Mid Land Avenue', 'Model Town', 'Moza Nigana Durana', 'Railway Officers Bungalows', 'Ram Kali', 'Rasheedabad', 'Rashid Minhas Road', 'Raza Abad', 'Rehmat Town', 'Royal Residency', 'Sabzazar Colony', 'Sabzi Mandi', 'Sadat Colony', 'Saddar Bazar', 'Saddiqia Road', 'Sadiq Colony', 'Sadiqabad', 'Sahara Homes', 'Sakhi Sultan Colony', 'Samanabad Colony', 'Sameeja Abad', 'Satellite Town', 'Sayyam City', 'Sayyam Officers City', 'Sewara Chowk', 'Shadab Colony', 'Shah Khuram Colony', 'Shah Rukn-e-Alam Colony', 'Shah Town', 'Shahzad Colony', 'Shalimar Colony', 'Shamasabad Colony', 'Sharifpura', 'Sher Shah Road', 'Shujabad', 'Shujabad Road', 'Sikanderabad', 'Silver City', 'Southern Bypass', 'Sui Gas Road', 'Suraj Miani', 'Suraj Miani Road', 'Tariq Abad(3)', 'Tariq Road(2)', 'Tariqabad(1)', 'Tawakal Town', 'Tehsil Chowk', 'Tibba Masoodpur', 'Timber Market', 'Tipu Sultan Road', 'Chungi No 14', 'Chungi No 22', 'Chungi No 6', 'Chungi No 7', 'Chungi No 8', 'Chungi No 9', 'Circuit House Colony', 'Crystal Homes', 'DHA Defence', 'Defence Officer Colony', 'Delhi Gate Multan', 'Dera Adda', 'Double Phatak Chowk', 'Dunya Pur Road', 'Eidgah Road', 'Faiz Town', 'Farooqpura', 'Fatima Jinnah Town', 'Fida Avenue', 'Fort Avenue', 'Furrukh Town', 'Galaxy Town', 'Garden Citi', 'Garden Town', 'Ghanta Ghar Chowk', 'Ghareeb Abad', 'Ghouspura', 'Gol Bagh Chowk', 'Green Fort Housing Scheme', 'Green Huts', 'Green View Colony', 'Gulberg Colony', 'Gulgasht Colony', 'Gulistan Chowk', 'Gulistan Housing Scheme', 'Gulraiz Town', 'Gulshan Market', 'Gulshan-E-Farooq Pura', 'Gulshan-e-Bashir', 'Gulshan-e-Faiz', 'Gulshan-e-Iqbal', 'Gulshan-e-Madina', 'Gulshan-e-Mehar', 'Gulshan-e-Rehman', 'Hafiz Jamal Road', 'Mujahid Town', 'Mukhtar Town', 'Multan Bypass', 'Multan Public School Road', 'Mumtazabad', 'N Gulgasht Boulevard', 'Nag Shah', 'Naka Chowk', 'Naqshband Colony', 'Nasheman Colony', 'Naubpur Road', 'Nawa Shehar', 'Nawab Pur', 'Nawabpur Road', 'Nayab City', 'Nehar Naubahar Road', 'New Ghalla Mandi', 'New Multan', 'New Shah Shams Colony', 'New Shalimar Colony', 'New Town', 'Niaz Town', 'Nishtar Chowk', 'Nishtar Road', 'North Gulgasht', 'Northern Bypass', 'Officers Canal Colony', 'Officers Colony', 'Officers Town', 'Old Shujabad Road', 'Others', 'PSIC Employees Housing Scheme', 'Pak Gate', 'Pearl City', 'Peer Colony', 'Peer Khurshed Colony', 'Peoples Colony', 'Piran Ghaib', 'Piran Ghaib Road', 'Police Lines 1', 'Prime Villas', 'Punjab Small Industries', 'Purana Shujabad Road', 'Qadirpur Ran', 'Qaiserabad', 'Qasim Bela', 'Qasimpur Colony', 'Univesity Road', 'Usman-e-Ghani Road', 'Vehari Chowk', 'Vehari Road', 'Walayatabad', 'Wapda Colony', 'Wapda Town', 'Waqas Town', 'Western Fort Colony', 'Writer Colony', 'Zaid Town', 'Zakariya Town','Others'];
  static List<String> bahawalpurSocieties=["AVENUE HOUSING SCHEME","Al-RAHEEM HOUSING SCHEME","FINE CITY HOUSING SOCIETY","AL-NOOR EXECUTIVE VILLAS","AL-SYED TOWN","SAFARI GARDEN","ALLAM IQBAL AVENUE","STALLITE TOWN","VALENCIA CITY","DHA BAHAWALPUR","CANAL VIEW HOUSING SCHEME","KHAVAR KHAN 243/D BLOCK V M.T.C","DREAM LAND HOUSING SOCIETY","TASNEEM ANSARIS RESIDENCE","WASAIB AVENUE","DHA BAHAWALPUR","STATE CITY SECTOR C","ALLAMA IQBAL TOWN","AMAN SOCIETY","AL BAGHDAD VILLAS HOUSING SOCIETY","AAREHMAN HOUSING SOCIETY","VALENCIA CITY HOUSING SOCIETY","AL HAIDER CITY","AL-NOOR EXECUTIVE VILLAS","BAGHDAD CITY HOUSING SOCIETY","VILLA COMMUNITY. DHA","KHAYABAN E AFZAL","AL KREEM GARDEN HOUSING SCHEME","GULSHAN E SAEED","AL MAKKAH GARDEN HOUSING SCHEME","REHMAN SOCIETY","GULISTAN E AKBAR TOWN","GULBERG AVENUE","GARDEN TOWN","KHYABAN E ALI HOUSING SOCIETY","STAR VILLAS","SHADMAN CITY","SHAHBAZ TOWN","AL MAJEED PARADISE","ALIZAI HOUSE","NAJAM HOUSE","AL NOOR GARDEN","TAIMOOR HOUSE","UMAR HOUSE","CH. A. MAJEED HOUSE","CITY GARDEN HOUSING SCHEME","AL JANNAT HOUSING SCHEME","TEACHER SOCIETY","AL HAIDER VIEW","ALLAMA IQBAL AVENUE","RIAZ UL JANNAH HOUSING SCHEME","STAR CITY HOUSING SCHEME","AL RAHEEM CITY AND PARADISE CITY","IBL BAHAWALPUR","GREEN ORCHARD","YOUSAF GARDEN","JABAN TOWN","HARAM VILLAS","CITY GARDEN","ZAKRIYA TOWN","UNIVERSITY TOWN","BAHAWALPUR LIFE STYLE","STATE GARDEN","MEHMOOD GARDEN","CRITICAL HOMES","JAMIA MASJID CANAL COLONY","DEPARTMENT OFF ANTHOMY","Others"];
  static List<String> rawalpindiSocieties=['Abdullah City', 'Abid Majeed Road', 'Adiala Road', 'Affandi Colony', 'Afshan Colony', 'Ahmad Abad', 'Air Force Housing Society', 'Airport Housing Society', 'Airport Road', 'Akalgarh', 'Al-Noor Colony', 'Ali Abad', 'Ali Town', 'Allahabad Road', 'Allama Iqbal Colony', 'Amarpura', 'Ameen Town', 'Amer Pura', 'Aria Mohalla', 'Army Officers Colony', 'Asghar Mall Road', 'Ashraf Colony', 'Askari', 'Aslam Colony', 'Aslam Shaheed Road', 'Awan Town', 'Ayub Colony', 'Azeem Town', 'Aziz Bhatti Shaheed Road', 'Azizabad', 'Babar Colony', 'Bagh Sardaran', 'Bahar Colony', 'Bahria Town Rawalpindi', 'Dhok Chaudhrian', 'Dhok Elahi Baksh', 'Dhok Gujran', 'Dhok Kala Khan', 'Dhok Kashmirian', 'Dhok Maira Jarahi', 'Dhok Mangtal', 'Dhok Mustaqeem Road', 'Dhok Paracha', 'Dhok Sayedan Road', 'Dhoke Banaras Road', 'Dhoke Dalal Road', 'Dhoke Gangal', 'Dhoke Hassu', 'Dhoke Khabba', 'Dhoke Munshi Khan', 'Dhoke Ratta', 'Dhoke Syedan', 'Eastridge Housing Scheme', 'Faisal Colony', 'Faizabad', 'Farooq-e-Azam Road', 'Fazaia Housing Scheme', 'Fazal Town', 'Friends Colony', 'GT Road', 'Gangaal', 'Garja', 'Gawal Mandi', 'Ghauri Town', 'Ghaziabad', 'Ghous-e-Azam Road', 'Ghousia Colony', 'Girja Road', 'Gorakhpur', 'Gulbahar Scheme', 'Gulistan Colony', 'Gulistan Fatima Colony', 'Gulraiz Housing Scheme', 'Gulshan Abad', 'Gulshan Dadan', 'Gulshan-e-Bahar', 'Gulshan-e-Iqbal', 'Gulshan-e-Khurshid Road', 'Gulshan-e-Saeed', 'Gulshan-e-Shamal', 'Gulshan-e-Zaheer Colony', 'Malik Colony', 'Mandra', 'Mangral Town', 'Marir Hassan', 'Media Town', 'Millat Colony', 'Misryal Road', 'Mohalla Banni', 'Mohammadi Colony', 'Mohan Pura', 'Morgah', 'Mughal Abad Road', 'Mumtaz Colony', 'Munawar Colony', 'Murree Road', 'Muslim Town', 'Naseerabad', 'National Garden Housing Scheme', 'Nawaz Colony', 'New Afzal Town', 'New Lalazar', 'Nussah Town', 'Others', 'PIA Colony', 'PWD Colony', 'Palm City', 'Peer Meher Ali Shah Town', 'People Colony(25)', 'Peshawar Road', 'Pindora', 'Pir Wadhai', 'Police Foundation Housing Scheme', 'Punjab Govt Servant Housing Foundation', 'Qasimabad', 'Quaid-e-Azam Colony', 'Rabia Bungalows Road', 'Race Course', 'Raheemabad', 'Rail View Housing Society', 'Railway Scheme 7', 'Railway Scheme 9', 'Raja Bazar', 'Range Road', 'Ranial', 'Rawal Road', 'Rawat', 'Rehmanabad', 'Bakra Mandi', 'Banaras Colony', 'Bangash Colony', 'Bank Road', 'Bankers Colony', 'Banni Chowk', 'Bassali', 'Bethsaida Colony', 'Bilal Colony', 'Bostan Road', 'Bostan Valley', 'CBR Town Phase 2', 'Caltex Road', 'Cantt(16)', 'Capital Awami Villas', 'Capital Housing Society', 'Capital Smart City', 'Chah Sultan', 'Chak Beli Khan', 'Chakbeli Road', 'Chaklala', 'Chaklala Scheme', 'Chakra', 'Chakra Road', 'Chakri', 'Chakri Road', 'Chandni Chowk', 'Chanman Abad', 'Chaudhary Jan Colony', 'Chungi No. 22 Road', 'Chur Chowk', 'City Villas', 'Civil Lines', 'Clifton Township', 'Cobb Line', 'College Road', 'Commercial Market', 'Committee Chowk', 'Cricket Stadium Road', 'DAV College Road', 'Defence Colony', 'Defence Road', 'Dhamyal Road', 'Dheri Hassanabad', 'Dhok Babu Irfan', 'Gulzar-e-Quaid Housing Society', 'Haji Chowk', 'Harley Street', 'High Court Road', 'Holy Family Road', 'Ideal Homes Society', 'Imam Bara Road', 'Islamabad Airport', 'Islamabad Farm Houses', 'Islamabad Highway', 'Jamia Masjid Road', 'Janjua Town', 'Jarahi', 'Jhanda Chichi', 'Jinnah Colony', 'Judicial Colony', 'Jumma Market', 'KRL Road', 'Kahuta', 'Kallar Syedan', 'Kalma Chowk', 'Kalyal Road', 'Kalyamabad', 'Kamala Abad', 'Kartar Pura', 'Khadim Hussain Road', 'Khanna Road', 'Khayaban-e-Faisal', 'Khayaban-e-Sir Syed', 'Khayaban-e-Tanveer', 'Khurram Colony', 'Kingdom Valley Islamabad', 'Kohat Road', 'Kohsar Town', 'Kotli Sattian', 'Kuri Road Area', 'Kurri Road','Lahore Islamabad Motorway', 'Lakhu Road', 'Lalarukh Colony', 'Lalazar', 'Lalazar 2', 'Lalazar Valley', 'Lalkurti', 'Liaquat Bagh', 'Liaquat Colony', 'Magistrate Colony', 'Riaz Qureshi Road', 'Sabzazar', 'Saddar', 'Sadiqa Abad', 'Sadiqabad', 'Safari View Residencia', 'Saidpur Road', 'Samarzar Housing Society', 'Sangar Town', 'Sarafa Bazar', 'Satellite Town', 'Shadman Town', 'Shah Khalid Colony', 'Shaheen Town', 'Shakrial', 'Shalley Valley', 'Shams Abad', 'Sher Zaman Colony', 'Shifa Cooperative Housing Society', 'Sir Syed Chowk', 'Sir Syed Road', 'Tali Mori', 'Tench Bhata', 'Tench Road', 'Tipu Road', 'Top City-1', 'Transformer Chowk', 'Tufail Road', 'Tulsa', 'Tulsa Road', 'Wah Link Road', 'Walait Homes', 'Walayat Colony', 'Waris Khan', 'Wazir Town', 'Westridge', 'Yousaf Colony', 'Zafar ul Haq Road', 'Zeeshan Colony','Others'];
}