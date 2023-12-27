import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';

class RealTimewl extends StatefulWidget {
  @override
  _RealTimewlState createState() => _RealTimewlState();
}

class _RealTimewlState extends State<RealTimewl> with SingleTickerProviderStateMixin {
  List<CategoryData> _categoryData = [];
  String FarmerID="F0001";
  String DeviceID=" ";
  CategoryData? selectedDevice;
  String? dropdowntypecase;
  //text field
  TextEditingController descriptionController = TextEditingController();

  // Get all categories from API
  Future<Null> getData() async {
    final response = await http
        .post(Uri.parse("http://10.131.78.75/sawahcek/getdevice.php"));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var jsonResult = jsonDecode(response.body);
        setState(() {
          for (Map user in jsonResult) {
            _categoryData.add(CategoryData.fromJson(user));
          }
        });
      }
    }
  }

  Future<Null> realtimeupdate() async {
    final response = await http
        .post(Uri.parse("http://10.131.78.75/sawahcek/realtimeupdate.php"));
    if (response.statusCode == 200) {
      print("done update");


    }
  }



  @override
  void initState() {
    super.initState();
    getData();
    realtimeupdate();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 71, 161, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 450,
            width: 1300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                  Text(
                    "REALTIME WATER LEVEL",
                    style: TextStyle(
                        color: Colors.white, fontSize: 40, wordSpacing: 10),
                  ),
                  Text(
                    "MONITORING SYSTEM",
                    style: TextStyle(
                        color: Colors.white, fontSize: 40, wordSpacing: 10),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    width: 330,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          " e-REPORT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Device :  ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            wordSpacing: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 225,
                        height: 50,
                        child: DropdownButtonFormField(
                          hint: Text(
                            "Select Device",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              wordSpacing: 10,
                            ),
                          ),
                          value: selectedDevice,
                          onChanged: (CategoryData? value) {
                            setState(() {

                              selectedDevice = value;
                              DeviceID="${selectedDevice?.cid}";
                              realtimeupdate();
                            });
                          },
                          items: _categoryData
                              .map(
                                (CategoryData cate) =>
                                DropdownMenuItem<CategoryData>(
                                  child: Text(cate.cname),
                                  value: cate,
                                ),
                          )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  Column(
                    children: [
                      GFProgressBar(
                        percentage: updatescala(),
                        lineHeight: 45,
                        width: 450,
                        alignment: MainAxisAlignment.spaceEvenly,
                        backgroundColor: Colors.black12,
                        progressBarColor: getProgressBarColor(updatescala()),
                      ),
                    ],
                  ),
                  // Display selected device details
                  if (selectedDevice != null)
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Status: ${selectedDevice!.level}",style:TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),),
                          // Add other details as needed
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 390,
                  width: 1300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (selectedDevice != null)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.update, // You can change this to the desired icon
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: () {
                                realtimeupdate();
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RealTimewl()),
                                );
                              },
                            ),
                            if (selectedDevice != null)
                              Column(
                                children: [
                                  Text("Updated by: ${selectedDevice?.lastupdate}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      )),
                                ],
                              ),

                          ],
                        ),
                      if (selectedDevice != null)
                      Container(
                        width: 400,
                        child:

                        Column(
                          children: [

                              Text("Real Time Scale: ${selectedDevice?.level}",style: TextStyle(fontSize: 25, color: Colors.white)),
                              Text("Water Level: ${selectedDevice?.scala} Meter",style: TextStyle(fontSize: 25, color: Colors.white),),


                            DropdownButtonFormField<String>(
                              itemHeight: 50,
                              hint: const Text('Select Type Case',style: TextStyle(fontSize: 20, color: Colors.black)),
                              value: dropdowntypecase,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdowntypecase = newValue!;
                                });
                              },
                              items: <String>[
                                'Low Level',
                                'High Level',
                                'Device damaged',
                                'Device lost'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),

                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: descriptionController,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors
                                      .white), // Set your desired text style

                              decoration: InputDecoration(
                                labelText: 'Description:',
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20), // Set label text color
                                contentPadding: EdgeInsets.all(
                                    16.0), // Add padding around the input area

                                // Add a border and customize its appearance
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),

                                // Change the border color when the field is focused
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 15.0)),
                      FloatingActionButton.extended(
                        label: Text('SUBMIT NOW',style: TextStyle(color: Color.lerp(Colors.blue, Colors.black, 0.8)),), // <-- Text
                        backgroundColor: Colors.blueAccent,
                        icon: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[900],

                          ),
                          child: Icon(
                            // <-- Icon
                            Icons.send,
                            size: 24.0,
                            color: Color.lerp(Colors.blue, Colors.black, 0.8),
                          ),
                        ),
                        onPressed: () {
                          sendDataToServer();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  double updatescala() {
    double? scalaValue = double.tryParse(selectedDevice?.scala ?? '');

    if (scalaValue != null) {
      // Use scalaValue for calculations
      double result =
          scalaValue; // Replace this line with your actual calculation
      print(result);
      return result;
    } else {
      // Handle the case where selectedDevice!.scala is not a valid double
      return 0.0;
    }
  }

  Future<void> sendDataToServer() async {


    Map<String, dynamic> postData = {
      'TypeCase': dropdowntypecase!,
      'Details': descriptionController.text,
      'FarmerID': FarmerID,
      'DeviceID': selectedDevice!.cid,

    };

    final response = await http.post(
      Uri.parse("http://10.131.78.75/sawahcek/insertcase.php"),
      body: postData,
    );



    if (response.statusCode == 200) {
      print("Server response: ${response.body}");
      // Handle successful response, e.g., show a success message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Data submitted successfully"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    } else {
      // Handle error response, e.g., show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to submit data. Please try again."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }



}

















Color getProgressBarColor(double value) {
  if (value < 0.2) {
    return Colors.orange;
  } else if (value >= 0.2 && value < 0.5) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

class ItemList extends StatelessWidget {
  final List<CategoryData> list;
  final CategoryData? selectedDevice; // Add this line

  ItemList({required this.list, this.selectedDevice}); // Update this line

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class CategoryData {
  var cid;
  var cname;
  var scala;
  var lastupdate;
  var level;

  CategoryData({this.cid, this.cname, this.scala, this.lastupdate,this.level});

  factory CategoryData.fromJson(Map<dynamic, dynamic> json) {
    return CategoryData(
      cid: json['DeviceID'],
      cname: json['Location'],
      scala: json['RealTimeScala'],
      lastupdate: json['LastUpdate'],
      level: json['RealTimeStatus'],
    );
  }
}
