import '../controller/login_controller.dart';

class ResetPassword {

  String email;
  String password;
  ResetPassword(this.email, this.password);

  ResetPassword.fromJson(Map<String, dynamic> json)
      :
        email = json['email'] as String,
        password = json['password'] as String;
  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password};

  Future<bool> reset() async {
    RequestController req = RequestController(path: "/sawahcek/reset_password.php");
    req.setBody(toJson());
    await req.put();

    if (req.status() == 200) {
      return true;
    }
    else{
      return false;
    }
  }
}