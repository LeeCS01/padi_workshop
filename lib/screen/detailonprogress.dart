import 'package:flutter/material.dart';

class Detailonprogress extends StatefulWidget {
  final List? list;
  final int? index;

  Detailonprogress({required this.index, required this.list});

  @override
  _DetailonprogressState createState() => _DetailonprogressState();
}

class _DetailonprogressState extends State<Detailonprogress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.list?[widget.index!]['DeviceID']}")),
      body: Container(
        height: 700.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 30.0)),

                Text("Warning: ${widget.list?[widget.index!]['RealTimeStatus']+ " water level at  "+"${widget.list?[widget.index!]['Location']}" ??  ''}", style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
                Text("Case Id: ${widget.list?[widget.index!]['CaseID'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Device Id: ${widget.list?[widget.index!]['DeviceID'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Report by : ${widget.list?[widget.index!]['fullname'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Farmer Id: ${widget.list?[widget.index!]['FarmerID'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Type Case: ${widget.list?[widget.index!]['TypeCase'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Details Case: ${widget.list?[widget.index!]['Details'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Water Level: ${widget.list?[widget.index!]['Status'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Date of Issues: ${widget.list?[widget.index!]['DateIssues'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Time of Issues: ${widget.list?[widget.index!]['TimeIssues'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Location: ${widget.list?[widget.index!]['Location'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Longitud: ${widget.list?[widget.index!]['Longitud'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Latitud: ${widget.list?[widget.index!]['Latitud'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Real Time Scala: ${widget.list?[widget.index!]['RealTimeScala'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Real Time Status: ${widget.list?[widget.index!]['RealTimeStatus'] ?? ''}", style: TextStyle(fontSize: 20.0,color: (['RealTimeStatus'] == "HIGH LEVEL") ? Colors.green : Colors.redAccent),),
                Text("Feedback from administor : ${widget.list?[widget.index!]['Feedback'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Padding(padding: const EdgeInsets.only(top: 30.0)),
                Text("Managed by : ${widget.list?[widget.index!]['AdminID'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Details Case: ${widget.list?[widget.index!]['CaseStatus'] ?? ''}", style: TextStyle(fontSize: 18.0)),

                Padding(padding: const EdgeInsets.only(top: 30.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

