import '../controller/login_controller.dart';

class LoginUser {
  int id;
  String fullname;
  String username;
  String phone;
  String address;
  String email;
  String password;
  String level;
  LoginUser(this.id,this.fullname,this.username, this.phone, this.address, this.email, this.password, this.level);

  LoginUser.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        fullname = json['fullname'] as String,
        username = json['username'] as String,
        phone = json['phone'] as String,
        address = json['address'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        level = json['level'] as String;

  Map<String, dynamic> toJson() =>
      {'id': id, 'fullname': fullname, 'username': username, 'phone': phone,
        'address': address, 'email': email, 'password': password,  'level': level};

  Future<bool> login() async {
    RequestController req = RequestController(path: "/sawahcek/login.php");
    req.setBody(toJson());
    await req.post();

    if (req.status() == 200) {
      id = req.result()['id'];
      fullname = req.result()['fullname'];
      username = req.result()['username'];
      phone = req.result()['phone'];
      address = req.result()['address'];
      email = req.result()['email'];
      password = req.result()['password'];
      level = req.result()['level'];
      return true;
    }
    else{
      return false;
    }
  }

  static Future<List<LoginUser>> loadByEmail(String email) async {
    List<LoginUser> result = [];
    RequestController req = RequestController(path: "/sawahcek/login.php");
    req.setBody({'email': email}); // Set the email in the request body
    await req.get();
    if (req.status() == 200 && req.result() != null) {
      for (var item in req.result()) {
        result.add(LoginUser.fromJson(item));
      }
    }
    return result;
  }
}