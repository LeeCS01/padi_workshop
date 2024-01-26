import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';
import 'package:sawahcek/screen/newdevicereq.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';




class Ereport extends StatefulWidget {
  @override
  _EreportState createState() => _EreportState();


  final List? list;
  final int? index;
  final String id;
  final String userid;


  Ereport({

    required this.list,
    required this.index,
    required this.id,
    required this.userid,
  });

}


class _EreportState extends State<Ereport> with SingleTickerProviderStateMixin {
  List<CategoryData> _categoryData = [];
  late String FarmerID;
  String DeviceID=" ";
  String locationName=" ";
  String wlstatus=" ";
  String level=" ";
  CategoryData? selectedDevice;
  String? dropdowntypecase;
  //text field
  TextEditingController descriptionController = TextEditingController();

  File? imageFile;
  final imagePicker = ImagePicker();


  // Get all categories from API
  Future<Null> getData() async {
    final response = await http
        .post(Uri.parse("http://10.131.73.13/sawahcek/getdevice.php"));

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



  @override
  void initState() {
    super.initState();
    FarmerID = widget.userid;
    locationName=widget.list![widget.index!]['slname'];
    getData();
    updatescala();
   DeviceID = widget.list![widget.index!]['DeviceID'];
    dropdowntypecase = widget.list![widget.index!]['RealTimeStatus'];
    wlstatus = widget.list![widget.index!]['RealTimeStatus'];
    level=widget.list![widget.index!]['RealTimeScala'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 248, 255, 20),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 390,
              width: 1300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
                color: Color.fromRGBO(21, 127, 193, 20),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 30.0)),
                    const Text(
                      "REALTIME WATER LEVEL",
                      style: TextStyle(
                          color: Colors.white, fontSize: 30, wordSpacing: 0,fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "MONITORING SYSTEM",
                      style: TextStyle(
                          color: Colors.white, fontSize: 30, wordSpacing: 0,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      width: 250,
                      height: 60,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            " E-report",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                wordSpacing: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Device :  ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          child: DropdownButtonFormField(

                            hint: Text(
                              locationName,

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                wordSpacing: 10,
                              ),
                            ),

                            value:selectedDevice,
                            onChanged: (CategoryData? value) {
                              setState(() {
                                selectedDevice = value;
                                locationName="${selectedDevice?.cname}";
                                DeviceID = "${selectedDevice?.cid}";
                                dropdowntypecase="${selectedDevice?.level}";
                                wlstatus="${selectedDevice?.level}";
                                level="${selectedDevice?.scala}";

                              });
                            },
                            items: _categoryData
                                .map(

                                  (CategoryData cate) => DropdownMenuItem<CategoryData>(
                                child: Text(cate.cname),
                                value: cate,
                              ),
                            )
                                .toList(),
                          ),

                        ),

                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Column(
                      children: [
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Set your desired border color
                              width: 2.0, // Set your desired border width
                            ),
                            borderRadius: BorderRadius.circular(30.0), // Set your desired border radius
                          ),
                          child: GFProgressBar(
                            percentage: updatescala(),
                            lineHeight: 50,
                            width: 345,
                            alignment: MainAxisAlignment.spaceEvenly,
                            backgroundColor: Colors.black12,

                            progressBarColor: getProgressBarColor(wlstatus),

                          ),
                        ),
                      ],
                    ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                            Text("Updated by: ${selectedDevice?.lastupdate ??widget.list?[widget.index!]['LastUpdate']}",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              child: Container(
                height: 1000,
                width: 1300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [

                    Text("Status: ${wlstatus}",style: TextStyle(fontSize: 20, color: Colors.black)),
                    Text("DeviceID: ${widget.list![widget.index!]['DeviceID']}",style: TextStyle(fontSize: 20, color: Colors.black)),
                    Text("slname: ${widget.list![widget.index!]['slname']}",style: TextStyle(fontSize: 20, color: Colors.black)),
                    Text("Water Level: ${level} Meter",style: TextStyle(fontSize: 20, color: Colors.black),),

                    Container(
                      width: 300,
                      height: 90,
                      child: DropdownButtonFormField<String>(
                        itemHeight: 50,
                        hint: const Text('Select Recorded Status', style: TextStyle(fontSize: 20, color: Colors.black)),

                        value: dropdowntypecase,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdowntypecase = newValue!;
                          });
                        },
                        items: <String>[
                          'Low Level',
                          'Normal Level',
                          'High Level',
                          'Device Damaged',
                          'Device Lost',
                          // Add your other status values here

                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust the alignment as needed
                        children: [
                          Expanded(
                            child: Container(
                              width: 400,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(21, 127, 193, 20),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Column (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: descriptionController,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Description:',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      contentPadding: EdgeInsets.all(26.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.transparent, // Set to transparent color
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20), // Adjust the spacing between the description column and dotted bar
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 200,
                              child: InkWell(
                                onTap: () {
                                  if (imageFile != null) {
                                    _showImagePopup();
                                  }
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  color: Colors.blueGrey,
                                  strokeWidth: 1,
                                  dashPattern: const [8, 8],
                                  child: SizedBox.expand(
                                    child: FittedBox(
                                      child: imageFile != null
                                          ? Image.file(File(imageFile!.path), fit: BoxFit.cover)
                                          : const Icon(
                                        Icons.image_outlined,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showPictureDialog();
                              },
                              child: const Center(
                                child: Text(
                                  'Take a Picture',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(padding: const EdgeInsets.only(top: 15.0)),

                    FloatingActionButton.extended(
                      label: Text('SUBMIT NOW',style: TextStyle(color: Color.lerp(Colors.blue, Colors.black, 0.8)),), // <-- Text
                      backgroundColor: const Color.fromRGBO(21, 127, 193, 20),
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

                        if (selectedDevice == null) {
                          // Handle the case when no device is selected
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Please select a device."),
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
                         } else {
                          sendDataToDB();
                        }
                      },


                    ),

                    Padding(padding: const EdgeInsets.only(top: 15.0)),

                    FloatingActionButton.extended(
                      label: Text('REQUEST NEW DEVICE ',style: TextStyle(color: Color.lerp(Colors.blue, Colors.black, 0.8)),), // <-- Text
                      backgroundColor: const Color.fromRGBO(21, 127, 193, 20),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>NewDeviceReq(id: widget.id,),
                          ),
                        );

                      },
                    ),
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );



  }


  Future<void> showPictureDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Action'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                getFromCamera();
                Navigator.of(context).pop();
              },
              child: const Text('Open Camera'),
            ),
            SimpleDialogOption(
              onPressed: () {
                getFromGallery();
                Navigator.of(context).pop();
              },
              child: const Text('Open Gallery'),
            ),
          ],
        );
      },
    );
  }

  void _showImagePopup() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox.expand(
            child: Image.file(File(imageFile!.path), fit: BoxFit.contain),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  getFromGallery() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  getFromCamera() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  double updatescala() {

    //print(data.isNotEmpty ? data[0]['RealTimeScala'] + " Meter" : getNewDataAndUpdateUI());

    double? scalaValue = double.tryParse( selectedDevice?.scala ?? widget.list?[widget.index!]['RealTimeScala'] );

    if (scalaValue != null) {
      double result =
          scalaValue / double.tryParse(selectedDevice?.depth ??widget.list?[widget.index!]['Depth'])!;

      if (result > 1.0) {
        result = 1.0;
      }


      return result;
    } else {


      return 0.0;
    }
  }

  Future<void> sendDataToDB() async {
    FarmerID=widget.userid;





    // Create a new multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.131.73.13/sawahcek/insertcase.php"),

    );

    // Add form data
    request.fields['TypeCase'] = dropdowntypecase!;
    request.fields['Details'] = descriptionController.text;
    request.fields['FarmerID'] = FarmerID;
    request.fields['DeviceID'] = selectedDevice!.cid;

    // Add the image file
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // Make sure this matches the name attribute in your PHP script
          imageFile!.path,
        ),
      );
    }

    try {
      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Server response: ${await response.stream.bytesToString()}");
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
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

}


Color getProgressBarColor(String value) {
  if (value == "Low Level") {
    return Colors.red;
  } else if (value == "Normal Level") {
    return Colors.yellow;
  } else if(value == "High Level"){
    return Colors.green;
  }else
    return Colors.black;
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
  var location;
  var scala;
  var lastupdate;
  var level;
  var depth;

  CategoryData({this.cid, this.cname, this.location,this.scala, this.lastupdate,this.level,this.depth});

  factory CategoryData.fromJson(Map<dynamic, dynamic> json) {
    return CategoryData(
      cid: json['DeviceID'],
      cname: json['slname'],
      location: json['Location'],
      scala: json['RealTimeScala'],
      lastupdate: json['LastUpdate'],
      level: json['RealTimeStatus'],
      depth: json['Depth'],
    );
  }
}