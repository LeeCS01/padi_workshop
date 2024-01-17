import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:sawahcek/screen/devicelist_screen_admin.dart';
import 'package:sawahcek/screen/login_screen.dart';
import '../model/device_model.dart';
import 'package:geolocator/geolocator.dart';


class Device extends StatefulWidget {
  const Device({Key? key}) : super(key: key);

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  final List<DeviceNew> Devices = [];
  final locationController = TextEditingController();
  final sizeController = TextEditingController(text: '');
  final statusController = TextEditingController(text: '');
  final slnameController = TextEditingController();
  final longitudController = TextEditingController();
  final latitudController = TextEditingController();
  final depthController = TextEditingController();
  var isObsecure = true.obs;
  var formKey = GlobalKey<FormState>();
  String address = '';
  String longitude = '';
  String latitude = '';


  void _addDevice() async {
    try{
      String location = locationController.text.trim();
      String longitud = longitudController.text.trim();
      String latitud = latitudController.text.trim();
      String size = sizeController.text.trim();
      String status = statusController.text.trim();
      String slname = slnameController.text.trim();
      String depth = depthController.text.trim();

      DeviceNew empang = DeviceNew( size, status, location, slname,longitud,latitud,depth);


      if (await empang.save()) {
        setState(() {
          Devices.add(empang);
          locationController.clear();
          sizeController.clear();
          statusController.clear();
          slnameController.clear();
          statusController.clear();
          longitudController.clear();
          latitudController.clear();
          depthController.clear();
          _showMessage("Device Successfully Registered.");

          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.pop(context); // Navigate back to DashboardAdmin
          });
        });
      }
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
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Register Device'),
            const Spacer(),
            PopupMenuButton<String>(
              onSelected: (value) {
                // Add your logic based on the selected value
                if (value == 'option1') {
                  // Handle option 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Devicelist(), // Navigate to SignupAdmin
                    ),
                  );
                }

                // Add more options as needed
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'option1',
                  child: Text('List Of Devices'),
                ),
                const PopupMenuItem<String>(
                  value: 'option2',
                  child: Text('Delete Existing Dam'),
                ),

                // Add more options as needed
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to DashboardAdmin
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(230, 248, 255, 20),
      body: ListView(
        shrinkWrap: true,
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
                      "Register Device",
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
                          DropdownButtonFormField<String>(
                            value: sizeController.text.isEmpty
                                ? null
                                : sizeController.text,
                            onChanged: (newValue) {
                              setState(() {
                                sizeController.text = newValue!;
                              });
                            },
                            validator: (val) =>
                            val == null ? "Please choose the size of the Device" : null,
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
                                Icons.photo_size_select_actual_outlined,
                                color: Colors.black,
                              ),
                              hintText: "Select Device size...",
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
                            value: statusController.text.isEmpty
                                ? null
                                : statusController.text,
                            onChanged: (newValue) {
                              setState(() {
                                statusController.text = newValue!;
                              });
                            },
                            validator: (val) =>
                            val == null ? "Please select your Device status" : null,
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
                              hintText: "Select Device status...",
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
                              hintText: "Enter Device location...",
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
                            controller: longitudController,
                            validator: (val) =>
                            val == "" ? "Please enter the longtitude of location " : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                              ),
                              hintText: "Enter Device longtitude...",
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
                            controller: latitudController,
                            validator: (val) =>
                            val == "" ? "Please enter the latitude of location " : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                              ),
                              hintText: "Enter Device latitude...",
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
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: depthController,
                            validator: (val) => val == "" ? "Please input the depth of location" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.vertical_align_bottom_rounded,
                                color: Colors.black,
                              ),
                              hintText: "Short name for location...",
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
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 450,
            padding: const EdgeInsets.all(16.0),
            child: OpenStreetMapSearchAndPick(
              center: const LatLong(2.3151691706839226, 102.32137389243178),
              buttonColor: Colors.blue,
              buttonText: 'Set Device Location',
              onPicked: (pickedData) {
                setState(() {
                  address = pickedData.address.toString();
                  longitude=pickedData.latLong.longitude.toString();
                  latitude=pickedData.latLong.latitude.toString();
                  locationController.text = address;
                  longitudController.text=longitude;
                  latitudController.text=latitude;
                });
                print(pickedData.address);
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      _addDevice();
                      // Handle the registration logic
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20, // Adjust the horizontal padding as needed
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
