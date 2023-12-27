import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailAdminReportCentre extends StatefulWidget {
  final List? list;
  final int? index;

  DetailAdminReportCentre({required this.index, required this.list});

  @override
  _DetailAdminReportCentreState createState() => _DetailAdminReportCentreState();
}

class _DetailAdminReportCentreState extends State<DetailAdminReportCentre> {
  TextEditingController descriptionController = TextEditingController();
  String AdminID = "A0002"; // Tolong Ubah nanti
  String? CaseStatus;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        width: 1300,
        height: 1700,
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Text(
              "REALTIME WATER LEVEL",
              style: TextStyle(color: Colors.white, fontSize: 40, wordSpacing: 5, fontWeight: FontWeight.bold),
            ),
            Text(
              "MONITORING SYSTEM",
              style: TextStyle(color: Colors.white, fontSize: 40, wordSpacing: 5, fontWeight: FontWeight.bold),
            ),
            Text(
              "ADMIN PAGE",
              style: TextStyle(color: Colors.white, fontSize: 15, wordSpacing: 5, fontWeight: FontWeight.bold),
            ),
            Card(
              color: Colors.lightBlue[600],
              shadowColor: Colors.black,
              child: Container(
                decoration: BoxDecoration(),
                width: 600,
                height: 1000,
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
                              "Case Id: ${widget.list?[widget.index!]['CaseID'] ?? ''}",
                              style: TextStyle(fontSize: 35.0, color: Colors.blue[900], fontWeight: FontWeight.bold),
                            ),
                            Text("Report by : ${widget.list?[widget.index!]['fullname'] ?? ''}", style: TextStyle(fontSize: 30.0)),
                            Text("Date of Issues: ${widget.list?[widget.index!]['DateIssues'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                            Text("Time of Issues: ${widget.list?[widget.index!]['TimeIssues'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text("-Device Information-", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                          Text("Location: ${widget.list?[widget.index!]['Location'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                          Text("Longitud: ${widget.list?[widget.index!]['Longitud'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                          Text("Latitud: ${widget.list?[widget.index!]['Latitud'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                          Text("Real Time Scala: ${widget.list?[widget.index!]['RealTimeScala'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                          Text(
                            "Real Time Status: ${widget.list?[widget.index!]['RealTimeStatus'] ?? ''}",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: (widget.list?[widget.index!]['RealTimeStatus'] == "HIGH LEVEL") ? Colors.green : Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0)),
                          Text("-Report Information-", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                          Text("Details Case: ${widget.list?[widget.index!]['Details'] ?? Text("Null")}", style: TextStyle(fontSize: 18.0)),
                          Padding(padding: const EdgeInsets.only(top: 20.0)),
                          Text("-Admin Reply Side-", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                          Text("Feedback from administor : ${widget.list?[widget.index!]['Feedback'] ?? Text("Null")}", style: TextStyle(fontSize: 18.0)),
                          Text("Managed by : ${widget.list?[widget.index!]['AdminID'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                          DropdownButtonFormField<String>(
                            itemHeight: 50,
                            hint: const Text('Select Case Status', style: TextStyle(fontSize: 20, color: Colors.black)),
                            value: widget.list?[widget.index!]['Feedback'],
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
                          Text("Your Feedback : ", style: TextStyle(fontSize: 18.0)),
                          TextField(
                            controller: descriptionController,
                            maxLines: 4,
                            style: TextStyle(fontSize: 16.0, color: Colors.white), // Set your desired text style
                            decoration: InputDecoration(
                              labelText: 'Description:',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                              contentPadding: EdgeInsets.all(16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 30.0)),
                    ElevatedButton(
                      onPressed: () {
                        sendDataToServer();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                        onPrimary: Colors.white,
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
    );
  }

  Future<void> sendDataToServer() async {
    Map<String, dynamic> postData = {
      'CaseID': widget.list?[widget.index!]['CaseID'].toString(),
      'Feedback': descriptionController.text,
      'AdminID': AdminID,
      'CaseStatus': CaseStatus,
    };

    final response = await http.post(
      Uri.parse("http://192.168.0.141/sawahcek/updatecase.php"),
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
