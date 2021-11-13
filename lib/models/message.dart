
class AppMessage{
  List<String>? replies;
  String? id;
  String? userId;
  String? message;
  DateTime? time;
  bool? isProperty;
  bool? isMedia;
  String? senderName;

  bool? loading;
  String? mediaUrl;
  String? propertyId;
  bool? showTime;
  AppMessage({this.replies,this.id,this.isProperty,this.message,this.propertyId,this.time,this.loading,this.senderName,this.userId,this.showTime,this.isMedia,this.mediaUrl});

  factory AppMessage.fromJson(Map<String,dynamic> data,String id){
    return AppMessage(
      id: id,
      userId: data['user_id'],
      message: data['message'],
      time: DateTime.parse(data['time']),
      isMedia:data['is_media'],
      loading:data['loading'],
      senderName: data['sender_name'],
      mediaUrl: data['media_url'],
      isProperty: data['is_property'] ?? false,
      showTime: data['show_time'],
      propertyId: data['property_id'],
    //  replies:data["replies"]!=null? List.from(data["replies"]):null
    );
  }

  toMap(){
    return {
      "user_id":userId,
      "message":message,
      "time":time?.toIso8601String(),
      "is_property":isProperty,
      "is_media":isMedia,
      'sender_name':senderName,
      "loading":loading,
      "media_url":mediaUrl,
      "property_id":propertyId,
      "show_time":showTime ?? false,
      "replies":this.replies??null,
    };
  }
}