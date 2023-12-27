import '../controller/signup_controller.dart';


class Level {
  int waterId;
  double level;
  String status;
  String dateTime;
  int id;
  int damId;

  Level(this.waterId, this. level, this.status, this.dateTime,  this.id, this.damId);

  Level.fromJson(Map<String, dynamic> json)
      : waterId = json['waterId'] as int,
        level = json['level'] as double,
        status = json['status'] as String,
        dateTime = json['dateTime'] as String,
        id = json['id'] as int,
        damId = json['damId'] as int;

  Map<String, dynamic> toJson() => {'waterId': waterId, 'level': level,
    'status': status, 'dateTime': dateTime, 'id': id, 'damId': damId};


}