import '../controller/signup_controller.dart';

class DeviceNew{
  //String DeviceID;
  String size;
  String status;
  String Location;
  String slname;
  String Longitud;
  String Latitud;
  String Depth;


  DeviceNew( this.size, this.status, this.Location, this.slname,this.Longitud,this.Latitud,this.Depth);

  DeviceNew.fromJson(Map<String, dynamic> json)
      :// DeviceID = json['DeviceID'] as String,
        size = json['size'] as String,
        status = json['status'] as String,
        Location = json['location'] as String,
        slname = json['slname'] as String,
  Longitud = json['Longitud'] as String,
  Latitud = json['Latitud'] as String,
  Depth = json['Depth'] as String;

  Map<String, dynamic> toJson() =>
      { 'size': size, 'status': status, 'Location': Location, 'slname': slname,'Longitud': Longitud,'Latitud': Latitud,'Depth': Depth,};


  Future<bool> save() async {
    // Proceed with saving the new user
    RequestController_SignUp req = RequestController_SignUp(path: "/sawahcek/newdevice_admin.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200) {
      return true; // User saved successfully
    }
    return false; // Failed to save user
  }

  static Future<List<DeviceNew>> loadAll() async {
    List<DeviceNew> result = [];
    RequestController_SignUp req = RequestController_SignUp(path: "/sawahcek/newdevice_admin.php");
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(DeviceNew.fromJson(item));
      }
    }
    return result;
  }
}