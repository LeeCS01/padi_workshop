import '../controller/signup_controller.dart';

class Empangan{
  int damId;
  String size;
  String status;
  String location;
  String slname;
  Empangan(this. damId, this.size, this.status, this.location, this.slname);

  Empangan.fromJson(Map<String, dynamic> json)
      : damId = json['damId'] as int,
        size = json['size'] as String,
        status = json['status'] as String,
        location = json['location'] as String,
        slname = json['slname'] as String;

  Map<String, dynamic> toJson() =>
      {'damId': damId, 'size': size, 'status': status, 'location': location, 'slname': slname};


  Future<bool> save() async {
    // Proceed with saving the new user
    RequestController_SignUp req = RequestController_SignUp(path: "/sawahcek/dam.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      return true; // User saved successfully
    }
    return false; // Failed to save user
  }

  static Future<List<Empangan>> loadAll() async {
    List<Empangan> result = [];
    RequestController_SignUp req = RequestController_SignUp(path: "/sawahcek/dam.php");
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(Empangan.fromJson(item));
      }
    }
    return result;
  }
}