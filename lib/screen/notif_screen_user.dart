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

  // void intstate() {
  //   super.initState();
  //   initPlatformState();
  // }
  // Future<void> initPlatformState() async {
  //   //Remove this method to stop OneSignal Debugging
  //   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  //
  //   OneSignal.initialize("dbdc2b8a-34f0-4b2d-882d-f933352ad28c");
  //
  //   // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //   OneSignal.Notifications.requestPermission(true);
  // }
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
                title: Text(widget.list?[i]['RealTimeStatus']+" AT "+widget.list?[i]['Location'] ?? ''),
                leading: Icon(Icons.warning),
                subtitle: Text("Advice : ${widget.list?[i]['Advice'] ?? ''}"),
                trailing: Text("Real Time Scala : ${widget.list?[i]['RealTimeScala'] + " Meter" ?? ''}"),
              ),
            ),
          ),
        );
      },
    );
  }
}


