import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      Uri.parse("http://10.131.78.75/sawahcek/getnotifdevice.php"),
      body: postData,
    );
return json.decode(response.body);

   /*final response =
    await http.get(Uri.parse("http://10.131.78.75/sawahcek/getnotifdevice.php"));
   return json.decode(response.body);
*/


  }
}

class ItemList extends StatelessWidget {
  final List? list;


  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailNotif(list: list, index: i),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(list?[i]['RealTimeStatus']+" AT "+list?[i]['Location'] ?? ''),
                leading: Icon(Icons.warning),
                subtitle: Text("Advice : ${list?[i]['Advice'] ?? ''}"),
                trailing: Text("Real Time Scala : ${list?[i]['RealTimeScala'] + " Meter" ?? ''}"),
              ),
            ),
          ),
        );
      },
    );
  }



}


