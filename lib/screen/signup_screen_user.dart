import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/signup_model.dart';
import 'login_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MaterialApp(
    home: Signup(),
  ));
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final List<SignUp> users = [];
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController levelController = TextEditingController(text: '');
  var isObsecure = true.obs;
  var formKey = GlobalKey<FormState>();

  void _addUser() async {
    try{
      String fullname = fullnameController.text.trim();
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String address = addressController.text.trim();
      String level = levelController.text.trim();
      SignUp ahli = SignUp(0, fullname, username, phone, address, email, password, level);

      if (await ahli.save()) {
        setState(() {
          users.add(ahli);
          fullnameController.clear();
          usernameController.clear();
          phoneController.clear();
          addressController.clear();
          levelController.clear();
          emailController.clear();
          passwordController.clear();
          _showMessage("SignUp Successful.");

          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          });
        });
      }else {
        _showMessage("Email and/or username already been used. Try another.");
      }
      emailController.clear();
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
  Widget build(BuildContext context) {
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

                  //signup signup form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 146, 192, 50),
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, -3),
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 8),
                        child: Column(
                          children: [
                            const Text("Real Time Water Level",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const Text("Monitoring System",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),

                            const SizedBox(height: 10,),

                            //name, email, password, signup button
                            Form(
                              key: formKey,
                              child: Column(

                                children: [
                                  //getting fullname from user
                                  TextFormField(
                                    controller: fullnameController,
                                    validator: (val) {
                                      if (val == "") {
                                        return "Please write your full name";
                                      } else if (!RegExp(r'^[a-zA-Z\s\-&/]*$').hasMatch(val!)) {
                                        return "Full name cannot contain number";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "full name...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 63, 100, 50),
                                          width: 3.0,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  TextFormField(
                                    controller: usernameController,
                                    validator: (val) => val == "" ? "Please write your username" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "username...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 63, 100, 50),
                                          width: 3.0,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // getting phone number from user
                                  TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validator: (val) {
                                      String phone = val?.trim() ?? "";
                                      if (phone.isEmpty) {
                                        return "Please enter your phone number";
                                      } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                                        return "Phone number can only contain digits";
                                      } else if (phone.length < 10 || phone.length > 12) {
                                        return "Phone number must be between 10 and 12 digits";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.phone_iphone,
                                        color: Colors.black,
                                      ),
                                      hintText: "phone no...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 63, 100, 50),
                                          width: 3.0,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  TextFormField(
                                    controller: addressController,
                                    validator: (val) => val == "" ? "Please write your address" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.map_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "address...",
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
                                            width: 3.0,                                          )
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  //getting email from user
                                  //getting email from user
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please write email";
                                      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$').hasMatch(val)) {
                                        return "Please enter a valid email (e.g., john@example.com)";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "email...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 63, 100, 50),
                                          width: 3.0,
                                        ),
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
                                  const SizedBox(height: 10,),

                                  //getting password from user
                                  Obx(
                                        () => TextFormField(
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == "" ? "Please write password" : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_outlined,
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
                                              width: 3.0,                                            )
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
                                  const SizedBox(height: 10,),

                                  // DropdownButtonFormField for level
                                  DropdownButtonFormField<String>(
                                    value: levelController.text.isEmpty ? null : levelController.text,
                                    onChanged: (newValue) {
                                      setState(() {
                                        levelController.text = newValue!;
                                      });
                                    },
                                    validator: (val) =>
                                    val == null ? "Please select the member level" : null,
                                    items: ['Member'].map((level) {
                                      return DropdownMenuItem(
                                        value: level,
                                        child: Text(level),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "Select member level",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 63, 100, 50),
                                          width: 3.0,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //already have an account and login here button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an Account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Login Here",
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


                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: ()
                            {
                              if(formKey.currentState!.validate()){
                                _addUser();
                                //registerAndSaveUserRecord();
                              }
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ),

                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        //width: MediaQuery.of(context).size.width,
                        height: 285,
                        child: Image.asset("images/1.png",),
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


