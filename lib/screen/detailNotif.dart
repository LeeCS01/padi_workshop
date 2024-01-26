import 'package:flutter/material.dart';

import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';


class DetailNotif extends StatefulWidget {
  final List? list;
  final int? index;

  DetailNotif({required this.index, required this.list});

  @override
  _DetailNotifState createState() => _DetailNotifState();
}

class _DetailNotifState extends State<DetailNotif> {


  @override
  Widget build(BuildContext context) {
    double latitude = double.tryParse(widget.list?[widget.index!]['Latitud'] ?? '') ?? 0.0;
    double longitude = double.tryParse(widget.list?[widget.index!]['Longitud'] ?? '') ?? 0.0;

    return Scaffold(
      appBar: AppBar(title: Text("${widget.list?[widget.index!]['DeviceID']}")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 30.0)),

                  // OpenStreetMapSearchAndPick widget for selecting a location
                  Container(
                    width: 400,
                    height: 400,
                    child: GestureDetector(
                      onTap: () {
                        // Do nothing when tapped
                      },
                      child: OpenStreetMapSearchAndPick(
                        center: LatLong(latitude, longitude),
                       // buttonColor: Colors.blue,
                        //buttonText: 'Set Dam Location',
                        onPicked: (pickedData) {
                         // print(pickedData.address);
                          setState(() {
                            //selectedLocation = pickedData;
                          });
                        },
                      ),
                    ),
                  ),

                  Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      color: _getStatusColor(widget.list?[widget.index!]['RecordedStatus']),
                      borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
                    ),
                    padding: EdgeInsets.all(5.0), // Add padding if necessary
                    child: Center(
                      child: Text(
                        "Warning: ${widget.list?[widget.index!]['RecordedStatus']} ",
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Text(
                    "${widget.list?[widget.index!]['slname']} ",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Information')),
                      DataColumn(label: Text('Details')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Device ID')),
                        DataCell(Text(widget.list?[widget.index!]['DeviceID'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Date')),
                        DataCell(Text(widget.list?[widget.index!]['Date'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Time')),
                        DataCell(Text(widget.list?[widget.index!]['Time'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Location')),
                        DataCell(Text(widget.list?[widget.index!]['slname'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Longitude')),
                        DataCell(Text(widget.list?[widget.index!]['Longitud'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Latitude')),
                        DataCell(Text(widget.list?[widget.index!]['Latitud'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Recorded Scale')),
                        DataCell(Text(widget.list?[widget.index!]['RecordedScala'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Recorded Status')),
                        DataCell(Text(widget.list?[widget.index!]['RecordedStatus'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Advice')),
                        DataCell(Text(widget.list?[widget.index!]['Advice'])),
                      ]),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 30.0)),
                ],

              ),
            ),
          ),
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
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Normal Level':
        return Colors.yellow;
      case 'High Level':
        return Colors.green;
      case 'Low Level':
        return Colors.red;
      default:
        return Colors.black; // Change this to the default color you want.
    }
  }

}
