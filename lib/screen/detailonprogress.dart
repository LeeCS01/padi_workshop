import 'package:flutter/material.dart';
import 'dart:convert';

class Detailonprogress extends StatefulWidget {
  final List? list;
  final int? index;

  Detailonprogress({required this.index, required this.list});

  @override
  _DetailonprogressState createState() => _DetailonprogressState();
}

class _DetailonprogressState extends State<Detailonprogress> {
  bool isImageExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.list?[widget.index!]['CaseID']}")),
      body: SingleChildScrollView(
        child: Container(
        
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                  Center(
                    child: Column(
                      children: [
                        Text(
                            "Warning: ${widget.list?[widget.index!]['RealTimeStatus']  ?? ''}",
                            style:
                                TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                        Text(
                            " ${widget.list?[widget.index!]['Location']}",
                            style:
                            TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),

                        Padding(padding: const EdgeInsets.only(top: 20.0)),

                        InkWell(
                          onTap: () {
                            setState(() {
                              // Toggle the image expansion state
                              isImageExpanded = !isImageExpanded;
                            });
                          },
                          child: Visibility(
                            visible: widget.list != null &&
                                widget.index != null &&
                                widget.index! < widget.list!.length &&
                                widget.list![widget.index!]['Image_data'] != null,
                            child: Builder(
                              builder: (context) {
                                try {
                                  // Attempt to decode the image data
                                  final decodedImage = base64.decode(
                                    widget.list![widget.index!]['Image_data'] ?? '',
                                  );

                                  // Check if the decoded image data is not empty
                                  if (decodedImage.isNotEmpty) {
                                    return isImageExpanded
                                        ? Image.memory(
                                      decodedImage,
                                      // Set the width to double.infinity for full size
                                      width: double.infinity,
                                    )
                                        : Image.memory(
                                      decodedImage,
                                      height: 200,
                                      width: 400,
                                    );
                                  } else {
                                    // Handle the case where the decoded image data is empty
                                    return Text('Empty Image Data');
                                  }
                                } catch (e) {
                                  // Handle decoding errors
                                  print('Error decoding image data: $e');
                                  return Text('Error Decoding Image Data');
                                }
                              },
                            ),
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(top: 20.0)),


                      ],

                    ),

                  ),
        
        
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Information')),
                      DataColumn(label: Text('Details')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Case ID')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['CaseID']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Device ID')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['DeviceID']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Reporter FullName')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['fullname']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Type Case')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['TypeCase']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Details')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Details']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Water Level Scala')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['RealTimeScala']}"+"Meter")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Recorded Water Level Status')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['TypeCase']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Date Of Issues')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['DateIssues']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Time of Issues')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['TimeIssues']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Location ')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['slname']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Address')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Location']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Longitude')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Longitud']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Latitude ')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Latitud']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Depth')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Depth']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Longitude')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Longitud']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Recorded Scala ')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Latitud']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Latest Update ')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['LastUpdate']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('FeedBack From Admin')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['Feedback']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Manage by Admin :')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['AdminID']}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Current Cases Status')),
                        DataCell(
                            Text("${widget.list?[widget.index!]['CaseStatus']}")),
                      ]),
                    
        
        
                      // Add more rows as needed
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
