import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/signup_model.dart';
import 'dam_screen.dart';
import 'login_screen.dart';
import 'package:flutter/services.dart';

void main() {

}

class ParasAir extends StatefulWidget {
  final String id;
  final String username;

  ParasAir({
    required this.id,
    required this.username,
  });


  @override
  _ParasAirState createState() => _ParasAirState();
}

class _ParasAirState extends State<ParasAir> {
  final TextEditingController levelController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController damIdController = TextEditingController();

  var isObsecure = true.obs;
  var formKey = GlobalKey<FormState>();

  void updateStatusMessage() {
    String levelValue = levelController.text.trim();
    if (levelValue.isEmpty) {
      statusController.text = ""; // Clear status if level is empty
      return;
    }

    double waterLevel = double.tryParse(levelValue) ?? 0.0;

    if (waterLevel < 5) {
      statusController.text = "Low water level";
    } else if (waterLevel >= 5 && waterLevel <= 10) {
      statusController.text = "Moderate water level";
    } else {
      statusController.text = "High water level";
    }
  }

  @override
  void initState() {
    super.initState();
    // Set initial date and time when the widget is initialized
    _updateDateTime();

    // Generate a random number between 0.00 and 20.00
    double randomLevel = _generateRandomLevel();
    levelController.text = randomLevel.toStringAsFixed(2);

    // Update the status message based on the generated random level
    updateStatusMessage();

    // Set the initial value of idController
    idController.text = widget.username;
  }

  double _generateRandomLevel() {
    // Generate a random double between 0.00 and 20.00
    return (Random().nextDouble() * 20.00);
  }

  void _updateDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} "
        "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";
    // Update the text in your controller
    setState(() {
      dateTimeController.text = formattedDateTime;
    });
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

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
                                    controller: levelController,
                                    validator: (val) =>
                                    val == "" ? "Please enter the water level value" : null,
                                    onChanged: (value) {
                                      updateStatusMessage();
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.water_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "water level in meter...",
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

                                  const SizedBox(height: 10,),

                                  // Status Column
                                  TextFormField(
                                    controller: statusController,
                                    validator: (val) => val == "" ? "Water level status" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.report_gmailerrorred_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "Water level status...",
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

                                  // DateTime Column
                                  TextFormField(
                                    controller: dateTimeController,
                                    validator: (val) => val == "" ? "Please write your date" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "Date and time...",
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
                                    controller: idController,
                                    validator: (val) => val == "" ? "Please write your address" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.map_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "user id...",
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
                                  TextFormField(
                                    controller: damIdController,
                                    enabled: false,
                                    validator: (val) => val == "" ? "Please write email" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "dam id...",
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

                                  //add space between email and password box
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            ),

                            //already have an account and login here button


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
                                //_addUser();
                                const Dam();
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
                                "Next",
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


