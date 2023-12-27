import 'package:flutter/material.dart';
import './notif_screen_user.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("${widget.list?[widget.index!]['DeviceID']}")),
      body: Container(
        height: 600.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              //var loc =${widget.list?[widget.index!]['Location']};
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 30.0)),
                Text("Warning: ${widget.list?[widget.index!]['RealTimeStatus']+ " water level at  "+"${widget.list?[widget.index!]['Location']}" ??  ''}", style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
                Text("DeviceID: ${widget.list?[widget.index!]['DeviceID'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Date: ${widget.list?[widget.index!]['Date'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Time: ${widget.list?[widget.index!]['Time'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Location: ${widget.list?[widget.index!]['Location'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Longitud: ${widget.list?[widget.index!]['Longitud'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Latitud: ${widget.list?[widget.index!]['Latitud'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Real Time Scala: ${widget.list?[widget.index!]['RealTimeScala'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Text("Real Time Status: ${widget.list?[widget.index!]['RealTimeStatus'] ?? ''}", style: TextStyle(fontSize: 20.0,color: (['RealTimeStatus'] == "HIGH LEVEL") ? Colors.green : Colors.redAccent),),
                Text("Advice : ${widget.list?[widget.index!]['Advice'] ?? ''}", style: TextStyle(fontSize: 18.0)),
                Padding(padding: const EdgeInsets.only(top: 30.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

