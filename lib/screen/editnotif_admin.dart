import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditNotifAdmin extends StatefulWidget {
  final String NotifID;

  EditNotifAdmin({required this.NotifID});

  @override
  _EditNotifAdminState createState() => _EditNotifAdminState();
}

class _EditNotifAdminState extends State<EditNotifAdmin> {
  late Future<Map<String, dynamic>> _deviceData;

  // Add formKey and controllers
  final formKey = GlobalKey<FormState>();
  final notifController = TextEditingController();
  final deviceController = TextEditingController();
  final recordedScalaController = TextEditingController();
  final recordedStatusController = TextEditingController();
  final dateController = TextEditingController();
  final timeController= TextEditingController();
  final adviceController= TextEditingController();
  final targetUserController= TextEditingController();


  @override
  void initState() {
    super.initState();
    _deviceData = fetchDeviceData(widget.NotifID);
  }

  // Add this function to your _EditDevicePageState class
  Future<void> updateDevice() async {
    final response = await http.post(
      Uri.parse("http://10.131.73.60/sawahcek/editnotif_admin.php"),
      body: {
        "NotifID": notifController.text,
        "DeviceID": deviceController.text,
        "RecordedScala": recordedScalaController.text,
        "RecordedStatus": recordedStatusController.text,
        "Date": dateController.text,
        "Time": timeController.text,
        "Advice": adviceController.text,
        "TargetUser": targetUserController.text,

      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification Updated")),

      );
      Navigator.pop(context);
    } else {
      print("Error deleting device: ${response.body}");
    }
  }


  Future<Map<String, dynamic>> fetchDeviceData(String NotifID) async {
    final response = await http.get(
      Uri.parse("http://10.131.73.60/sawahcek/getnotifspec.php?NotifID=$NotifID"),
    );

    Map<String, dynamic> data = json.decode(response.body);

    notifController.text=data['NotifID']??'';
    deviceController.text = data['DeviceID'] ?? '';
    recordedScalaController.text = data['RecordedScala'] ?? '';
    recordedStatusController.text = data['RecordedStatus'] ?? '';
    dateController.text = data['Date'] ?? '';
    timeController.text = data['Time'] ?? '';
    adviceController.text = data['Advice'] ?? '';
    targetUserController.text = data['TargetUser'] ?? '';


    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notification'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _deviceData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Now you can access the device data and use it to pre-fill the form fields
          final deviceData = snapshot.data!;

          return Center(
            child: SingleChildScrollView( // Added SingleChildScrollView to avoid overflow issues
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Column(
                          children: [
                            const Text(
                              "Edit Notification Information",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: notifController,
                                    enabled: false, // Set this to false to make it non-editable
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.perm_device_info_rounded,
                                        color: Colors.black,
                                      ),
                                      // hintText: "Short name for location...",
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


                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: deviceController,
                                    validator: (val) =>
                                    val == "" ? "Please enter the location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "Enter dam location...",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Color.fromRGBO(0, 63, 100, 50),
                                            width: 3.0,
                                          )),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: recordedScalaController,
                                    validator: (val) => val == "" ? "Please write the short name for the location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.black,
                                      ),
                                      hintText: "Short name for location...",
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


                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: recordedStatusController,
                                    validator: (val) => val == "" ? "Please write the logitude of location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.map_rounded,
                                        color: Colors.black,
                                      ),
                                      //hintText: "Short name for location...",
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


                                  const SizedBox(
                                    height: 10,
                                  ),

                                  TextFormField(
                                    controller: dateController,
                                    validator: (val) => val == "" ? "Please write the latitude of location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.map_rounded,
                                        color: Colors.black,
                                      ),
                                      //hintText: "Short name for location...",
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


                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: timeController,
                                    validator: (val) => val == "" ? "Please write the depth of location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.legend_toggle,
                                        color: Colors.black,
                                      ),
                                      //hintText: "Short name for location...",
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


                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: adviceController,
                                    validator: (val) => val == "" ? "Please write the scala of location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.priority_high,
                                        color: Colors.black,
                                      ),
                                      //hintText: "Short name for location...",
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


                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: targetUserController,
                                    validator: (val) => val == "" ? "Please write the scala of location" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.priority_high,
                                        color: Colors.black,
                                      ),
                                      //hintText: "Short name for location...",
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

                                  ElevatedButton(
                                    onPressed: () {
                                      // Call the updateDevice function when the button is pressed
                                      updateDevice();
                                    },
                                    child: Text('Update'),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
