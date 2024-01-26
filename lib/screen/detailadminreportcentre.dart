import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailAdminReportCentre extends StatefulWidget {
  final List? list;
  final int? index;
  final String adminid;

  DetailAdminReportCentre({required this.index, required this.list, required this.adminid});

  @override
  _DetailAdminReportCentreState createState() => _DetailAdminReportCentreState();
}

class _DetailAdminReportCentreState extends State<DetailAdminReportCentre> {
  TextEditingController descriptionController = TextEditingController();
  String? CaseStatus;

  @override
  void initState() {
    super.initState();

  }

  Widget getImageWidget() {
    String imageData =
    widget.list != null && widget.index != null && widget.index! < widget.list!.length
        ? widget.list![widget.index!]['Image_data'] ?? ''
        : "";

    if (imageData.isNotEmpty) {
      return Image.memory(
        base64.decode(imageData),
        height: 200,
        width: 400, // Set the height as needed
      );
    } else {
      // Display a default icon or image when image data is empty or null
      return Icon(
        Icons.image_not_supported,
        size: 100,
        color: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text(
                  "REALTIME WATER LEVEL",
                  style: TextStyle(color: Colors.white, fontSize: 30, wordSpacing: 0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "MONITORING SYSTEM",
                  style: TextStyle(color: Colors.white, fontSize: 30, wordSpacing: 0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "ADMIN PAGE",
                  style: TextStyle(color: Colors.white, fontSize: 20, wordSpacing: 0, fontWeight: FontWeight.bold),
                ),
                Card(
                  color: Colors.lightBlue[600],
                  shadowColor: Colors.black,
                  child: Container(
                    width: 600,
                    height: 1100,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 500,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              color: Colors.blue[700],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Case Id: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['CaseID'] ?? '' : 'Index out of bounds'}",
                                  style: TextStyle(fontSize: 35.0, color: Colors.blue[900], fontWeight: FontWeight.bold),
                                ),
                                Text("Report by : ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['fullname'] ?? '' : ''}",
                                    style: TextStyle(fontSize: 30.0)),
                                Text("Date of Issues: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['DateIssues'] ?? '' : ''}",
                                    style: TextStyle(fontSize: 18.0)),
                                Text("Time of Issues: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['TimeIssues'] ?? '' : ''}",
                                    style: TextStyle(fontSize: 18.0)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 500,
                          height: 800,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text("-Device Information-", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                              Text("Location: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['Location'] ?? '' : ''}",
                                  style: TextStyle(fontSize: 18.0)),
                              Text("Longitud: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['Longitud'] ?? '' : ''}",
                                  style: TextStyle(fontSize: 18.0)),
                              Text("Latitud: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['Latitud'] ?? '' : ''}",
                                  style: TextStyle(fontSize: 18.0)),
                              Text("Real Time Scala: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['RealTimeScala'] ?? '' : ''}",
                                  style: TextStyle(fontSize: 18.0)),
                              Text(
                                "Real Time Status: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['RealTimeStatus'] ?? '' : ''}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: (widget.list != null &&
                                      widget.index != null &&
                                      widget.index! < widget.list!.length &&
                                      widget.list![widget.index!]['RealTimeStatus'] == "HIGH LEVEL")
                                      ? Colors.green
                                      : Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(padding: const EdgeInsets.only(top: 10.0)),
                              Text("-Report Information-", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                              Text("Details Case: ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['Details'] ?? 'Null' : 'Null'}",
                                  style: TextStyle(fontSize: 18.0)),
                              Padding(padding: const EdgeInsets.only(top: 20.0)),

                              // Image widget handling empty or null image data
                              getImageWidget(),

                              Padding(padding: const EdgeInsets.only(top: 20.0)),

                              Text("-Admin Reply Side-", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                              Text(
                                  "Feedback from administrator : ${widget.list![widget.index!]['Feedback'] }",
                                  style: TextStyle(fontSize: 18.0)),
                              Text("Managed by : ${widget.list != null && widget.index != null && widget.index! < widget.list!.length ? widget.list![widget.index!]['AdminID'] ?? '' : ''}",
                                  style: TextStyle(fontSize: 18.0)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                  itemHeight: 50,
                                  hint: const Text('Select Case Status', style: TextStyle(fontSize: 20, color: Colors.black)),
                                  value:  widget.list![widget.index!]['CaseStatus'],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      CaseStatus = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'INREQ',
                                    'ONPROGRESS',
                                    'DONE ',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("Your Feedback : ", style: TextStyle(fontSize: 18.0)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: descriptionController,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Description:',
                                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 10.0)),
                        ElevatedButton(
                          onPressed: () {
                            sendDataToServer();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            textStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.blue[900]!),
                            ),
                            elevation: 5.0,
                            shadowColor: Colors.black,
                          ),
                          child: Text("Reply"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendDataToServer() async {

    print( widget.list![widget.index!]['CaseID']);
    print( descriptionController.text);
    print( widget.list![widget.index!]['AdminID']);
    print( CaseStatus);

    Map<String, dynamic> postData = {
      'CaseID': widget.list![widget.index!]['CaseID'],
      'Feedback': descriptionController.text,
      'AdminID': widget.adminid,
      'CaseStatus': CaseStatus,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/updatecase.php"),
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
