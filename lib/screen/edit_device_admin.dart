import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditDevicePage extends StatefulWidget {
  final String deviceID;

  EditDevicePage({required this.deviceID});

  @override
  _EditDevicePageState createState() => _EditDevicePageState();
}

class _EditDevicePageState extends State<EditDevicePage> {
  late Future<Map<String, dynamic>> _deviceData;

  // Add formKey and controllers
  final formKey = GlobalKey<FormState>();
  final sizeController = TextEditingController();
  final statusController = TextEditingController();
  final locationController = TextEditingController();
  final slnameController = TextEditingController();
  final longitudController = TextEditingController();
  final latitudController= TextEditingController();
  final depthController= TextEditingController();
  final realtimescalaController= TextEditingController();
  final realtimestatusController= TextEditingController();
  final deviceController=TextEditingController();

  @override
  void initState() {
    super.initState();
    _deviceData = fetchDeviceData(widget.deviceID);
  }

  // Add this function to your _EditDevicePageState class
  Future<void> updateDevice() async {
    final response = await http.post(
      Uri.parse("http://10.131.73.60/sawahcek/editDevice_admin.php"),
      body: {
        "deviceID": deviceController.text,
        "size": sizeController.text,
        "status": statusController.text,
        "location": locationController.text,
        "slname": slnameController.text,
        "longitud": longitudController.text,
        "latitud": latitudController.text,
        "depth": depthController.text,
        "realTimeScala": realtimescalaController.text,
        "realTimeStatus": realtimestatusController.text,
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Device Updated")),

      );
      Navigator.pop(context);
    } else {
      print("Error deleting device: ${response.body}");
    }
  }


  Future<Map<String, dynamic>> fetchDeviceData(String deviceID) async {
    final response = await http.get(
      Uri.parse("http://10.131.73.60/sawahcek/getdevicespec.php?deviceID=$deviceID"),
    );

    Map<String, dynamic> data = json.decode(response.body);

    deviceController.text=data['DeviceID']??'';
    sizeController.text = data['size'] ?? '';
    statusController.text = data['status'] ?? '';
    locationController.text = data['Location'] ?? '';
    slnameController.text = data['slname'] ?? '';
    longitudController.text = data['Longitud'] ?? '';
    latitudController.text = data['Latitud'] ?? '';
    depthController.text = data['Depth'] ?? '';
    realtimescalaController.text = data['RealTimeScala'] ?? '';
    realtimestatusController.text = data['RealTimeStatus'] ?? '';

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Device'),
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
                              "Edit Device Information",
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
                                    controller: deviceController,
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

                                  DropdownButtonFormField<String>(
                                    value: deviceData['size'], // Use deviceData to pre-fill values
                                    onChanged: (newValue) {
                                      setState(() {
                                        sizeController.text = newValue!;
                                      });
                                    },
                                    validator: (val) =>
                                    val == null ? "Please select status" : null,
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Small",
                                        child: Text("Small"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Medium",
                                        child: Text("Medium"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Large",
                                        child: Text("Large"),
                                      ),

                                    ],
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.stacked_bar_chart_sharp,
                                        color: Colors.black,
                                      ),
                                      hintText: "Select dam size...",
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
                                  DropdownButtonFormField<String>(
                                    value: deviceData['status'], // Use deviceData to pre-fill values
                                    onChanged: (newValue) {
                                      setState(() {
                                        statusController.text = newValue!;
                                      });
                                    },
                                    validator: (val) =>
                                    val == null ? "Please select your dam status" : null,
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Private",
                                        child: Text("Private"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Public",
                                        child: Text("Public"),
                                      ),
                                    ],
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_lock_rounded,
                                        color: Colors.black,
                                      ),
                                      hintText: "Select dam status...",
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
                                    controller: locationController,
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
                                    controller: slnameController,
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
                                    controller: longitudController,
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
                                    controller: latitudController,
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
                                    controller: depthController,
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
                                    controller: realtimescalaController,
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
                                  DropdownButtonFormField<String>(
                                    value: deviceData['RealTimeStatus'], // Use deviceData to pre-fill values
                                    onChanged: (newValue) {
                                      setState(() {
                                        realtimestatusController.text = newValue!;
                                      });
                                    },
                                    validator: (val) =>
                                    val == null ? "Please select your real time status" : null,
                                    items: const [
                                      DropdownMenuItem(
                                        value: "NOT READY",
                                        child: Text("NOT READY"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Low Level",
                                        child: Text("Low Level"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Normal Level",
                                        child: Text("Normal Level"),
                                      ),
                                      DropdownMenuItem(
                                        value: "High Level",
                                        child: Text("High Level"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Damage",
                                        child: Text("Damage"),
                                      ),
                                    ],
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.stacked_bar_chart_sharp,
                                        color: Colors.black,
                                      ),
                                      hintText: "Select dam status...",
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
