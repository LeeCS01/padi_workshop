import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawahcek/screen/dashboard_screen_admin.dart';
import 'package:sawahcek/screen/signup_screen_admin.dart';
import 'package:sawahcek/screen/signup_screen_user.dart';

import '../model/login_model.dart';
import 'dashboard_screen_user.dart';
import 'forgot_password_screen.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final List<Login> users = [];
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isObsecure = true.obs;

  void _userLogin() async {
    try{
      int id = 0;
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String fullname = "";
      String username = "";
      String phone = "";
      String address = "";
      String level = "";
      LoginUser logins = LoginUser(id, fullname, username, phone, address, email, password, level);
      if (await logins.login()) {
        setState(() {
          //users.add(logins);
          emailController.clear();
          passwordController.clear();

          _showMessage("Login Successful.");

          // Print user data
          print("User ID: ${logins.id}");
          print("Fullname: ${logins.fullname}");
          print("Username: ${logins.username}");
          print("Address: ${logins.address}");
          print("No. Phone: ${logins.phone}");
          print("Email: ${logins.email}");
          print("Password: ${logins.password}");
          print("Level: ${logins.level}");

          Future.delayed(const Duration(milliseconds: 2000), () {
            String lowerCaseLevel = logins.level.toLowerCase();

            if (lowerCaseLevel == "admin") {
              // Navigate to register screen for admin
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardAdmin(
                  id: logins.id.toString(),
                  fullname: logins.fullname,
                  username: logins.username,
                  email: logins.email,
                  password: logins.password,
                ),),
              );
            } else if (lowerCaseLevel == "member") {
              // Navigate to dashboard screen for member
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardUser(
                    id: logins.id.toString(),
                    fullname: logins.fullname,
                    username: logins.username,
                    email: logins.email,
                    password: logins.password,
                  ),
                ),
              );
            }

            // ... (other conditions based on user's level)
          });
        });

      }else {
        _showMessage("Invalid email or password.");
      }
      emailController.clear();
      passwordController.clear();

    }
    catch(e) {
      _showMessage(e.toString());
    }
  }

  void _showMessage(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }
  }
   

  @override
  Widget build(BuildContext index) {

    return Scaffold(

      backgroundColor: const Color.fromRGBO(230, 248, 255, 20),
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(

              child: Column(

                children: [
                  //const SizedBox(height: 50,),
                  //login header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset("images/GUI.png",),
                  ),

                  const SizedBox(height: 20,),

                  const Text("SawahCek",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 63, 100, 50),
                    ),
                  ),

                  const Text("Real Time Water Level",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 63, 100, 50),
                    ),
                  ),

                  const Text("Monitoring System",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 63, 100, 50),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  //login sign-in form
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                    child: Column(
                      children: [
                        //email, password, login button
                        Form(
                          key: formKey,
                          child: Column(
                            children: [

                              //getting email from user
                              TextFormField(
                                controller: emailController,
                                validator: (val) => val == "" ? "Please write email" : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: "email...",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(0, 63, 100, 50),
                                        width: 3.0,
                                      )
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),

                              ),

                              //add space between email and password box
                              const SizedBox(height: 18,),

                              //getting password from user
                              Obx(
                                    () => TextFormField(
                                  controller: passwordController,
                                  obscureText: isObsecure.value,
                                  validator: (val) => val == "" ? "Please write password" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.vpn_key_sharp,
                                      color: Colors.black,
                                    ),
                                    //add icon to hide and show password
                                    suffixIcon: Obx(
                                          ()=> GestureDetector(
                                        onTap: () {
                                          isObsecure.value = !isObsecure.value;
                                        },
                                        child: Icon(
                                          isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    hintText: "password...",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 63, 100, 50),
                                          width: 3.0,
                                        )
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),

                                ),
                              ),

                              //add space between login and password box
                              const SizedBox(height: 18,),
                            ],
                          ),
                        ),
                        /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Are you an Admin"),
                                TextButton(
                                  onPressed: () {

                                  },
                                  child: const Text("Click Here",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.lightBlueAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),*/
                      ],
                    ),//sini login
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: ()
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text(
                                "Register ?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Material(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: ()
                            {
                              if(formKey.currentState!.validate()){
                                _userLogin();
                              }
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add the "Forgot Password" link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Forgot Password?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Click Here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
