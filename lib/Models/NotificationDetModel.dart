import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Notification {
  String notification_id;
  String notification_title;
  String notification_content;
  String notification_desc;
  String add_date;
  String att_name;

  Notification({
    this.notification_id,
    this.notification_title,
    this.notification_content,
    this.notification_desc,
    this.add_date,
    this.att_name,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable()
class NotificationList {
  List<Notification> notification;

  NotificationList({this.notification});
  factory NotificationList.fromJson(List<dynamic> json) {
    return NotificationList(
        notification: json
            .map((e) => Notification.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

Notification _$NotificationDataFromJson(Map<String, dynamic> json) {
  return Notification(
    notification_id: json['notification_id'].toString() as String,
    notification_title: json['notification_title'] as String,
    notification_content: json['notification_content'] as String,
    notification_desc: json['notification_desc'] as String,
    add_date: json['add_date'] as String,
    att_name: json['att_name'] as String,
  );
}

Map<String, dynamic> _$NotificationDataToJson(Notification instance) =>
    <String, dynamic>{
      'notification_id': instance.notification_id,
      'notification_title': instance.notification_title,
      'notification_content': instance.notification_content,
      'add_date': instance.add_date,
      'att_name': instance.att_name,
    };
