import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawahcek/model/forgot_password_model.dart';
import 'package:sawahcek/screen/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isObsecure = true.obs;

  _reset() async{
    try {
      ResetPassword reset = ResetPassword(
          emailController.text, passwordController.text);
      if (await reset.reset()) {

        _showMessage("Password has been reset");
        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });

      } else {
        _showMessage("Invalid email. Failed to reset password");
      }
    }catch(e) {
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
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Reset Password'),
          ],
        ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to DashboardAdmin
            },
          ),
        ),
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

                  const Text("SawahCheck",
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

                              //add space between login and password box
                              const SizedBox(height: 18,),

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
                              _reset();
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text(
                                "Reset Password",
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
