
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sawahcek/screen/detailNotif.dart';

class Notif extends StatefulWidget {
  // const Notif({Key? key}) : super(key: key);



  @override
  State<Notif> createState() => _NotifState();
  final String id;
  final String username;


  Notif({
    required this.id,
    required this.username,
  });

}

class _NotifState extends State<Notif> {

  String TargetUser='1';



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: FutureBuilder<List?>(
        future: sendDataToServer(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(
            list: snapshot.data,
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List?> sendDataToServer() async {


    print(widget.id);
    Map<String, dynamic> postData = {
      'TargetUser': widget.id,
    };

    final response = await http.post(
      Uri.parse("http://10.131.73.13/sawahcek/getnotifdevice.php"),
      body: postData,
    );
    return json.decode(response.body);
  }
}

class ItemList extends StatefulWidget {
  final List? list;


  ItemList({required this.list});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list?.length ?? 0,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailNotif(list: widget.list, index: i),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(
              widget.list?[i]['RecordedStatus'] + " AT " + widget.list?[i]['Location'] ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust the text color
                ),
              ),
              leading: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.red, // Set the background color of the icon container
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning,
                  color: Colors.white, // Set the icon color
                ),
              ),
              subtitle: Text(
                "Advice : ${widget.list?[i]['Advice'] ?? ''}",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey, // Adjust the text color
                ),
              ),
              trailing: Container(
                width: 0,
                height: 150,
                decoration: BoxDecoration(
                  color: _getBackgroundColor(widget.list?[i]['RecordedStatus']),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    "Recorded Scala : ${widget.list?[i]['RecordedScala'] + " Meter" ?? ''}",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white, // Adjust the text color
                    ),
                  ),
                ),
              ),

            ),
          ),
        ),
        );
      },
    );
  }
  Color _getBackgroundColor(String? recordedStatus) {
    if (recordedStatus == "Low Level") {
      return Colors.green;
    } else if (recordedStatus == "Normal Level") {
      return Colors.yellow;
    } else if (recordedStatus == "High Level") {
      return Colors.red;
    } else {
      // Default color if the status is not recognized
      return Colors.grey;
    }
  }

}